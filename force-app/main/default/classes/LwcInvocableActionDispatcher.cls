/**
 * @description LWC exposed class that allows dynamically instantiating and running
 * ILwcInvocableAction implementations
 */
public with sharing class LwcInvocableActionDispatcher {
    @testVisible
    private static final String CLASS_DOESNT_EXIST_EXCEPTION_MESSAGE = 'Class {0} does not exist';

    @testVisible
    private static final String CLASS_ISNT_ACTION_EXCEPTION_MESSAGE = 'Class {0} is not an LwcInvocableAction';

    @testVisible
    private static final String CLASS_NAME_REQUIRED_EXCEPTION_MESSAGE = 'className is required';

    /**
     * @description Given the name of a class that implements ILwcInvocableAction, dynamically instantiate that
     * class and run the action() method using the input request. This method uses the LDS cache and may return
     * cached results if called with the same inputs.
     * Consider the restrictions and implications of calling cacheable or non-cacheable methods
     * (https://developer.salesforce.com/docs/platform/lwc/guide/apex-result-caching.html)
     * @param className the qualified class name of the ILwcInvocableAction implementation. If the class belongs in a
     * namespace, the full qualified class name <namespace>.<class name> must be passed
     * @param actionRequest an LwcInvocableActionRequest that contains optional input and options to pass to the run()
     * method
     * @return an LwcInvocableActionOutput object returned from the run() method
     */
    @AuraEnabled(cacheable=true)
    public static LwcInvocableActionResponse runCacheableAction(
        String className,
        LwcInvocableActionRequest actionRequest
    ) {
        try {
            return runAction(className, actionRequest);
        } catch (Exception e) {
            String auraExcMessage = String.format('{0}: {1}', new List<String>{ e.getTypeName(), e.getMessage() });
            AuraHandledException auraExc = new AuraHandledException(auraExcMessage);
            auraExc.setMessage(auraExcMessage);
            throw auraExc;
        }
    }

    /**
     * @description Given the name of a class that implements ILwcInvocableAction, dynamically instantiate that
     * class and run the action() method using the input request. This method does not use the LDS cache and the run()
     * method will be called every time even if passed the same inputs.
     * Consider the restrictions and implications of calling cacheable or non-cacheable methods
     * (https://developer.salesforce.com/docs/platform/lwc/guide/apex-result-caching.html)
     * @param className the qualified class name of the ILwcInvocableAction implementation. If the class belongs in a
     * namespace, the full qualified class name <namespace>.<class name> must be passed
     * @param actionRequest an LwcInvocableActionRequest that contains optional input and options to pass to the run()
     * method
     * @return an LwcInvocableActionOutput object returned from the run() method
     */
    @AuraEnabled(cacheable=false)
    public static LwcInvocableActionResponse runNonCacheableAction(
        String className,
        LwcInvocableActionRequest actionRequest
    ) {
        try {
            return runAction(className, actionRequest);
        } catch (Exception e) {
            String auraExcMessage = String.format('{0}: {1}', new List<String>{ e.getTypeName(), e.getMessage() });
            AuraHandledException auraExc = new AuraHandledException(auraExcMessage);
            auraExc.setMessage(auraExcMessage);
            throw auraExc;
        }
    }

    private static LwcInvocableActionResponse runAction(String className, LwcInvocableActionRequest actionRequest) {
        if (String.isBlank(className)) {
            throw new LwcInvocableActionException(CLASS_NAME_REQUIRED_EXCEPTION_MESSAGE);
        }
        return getActionInstance(className).run(actionRequest?.input, actionRequest?.options);
    }

    private static ILwcInvocableAction getActionInstance(String className) {
        Type classType = Type.forName(className);
        if (classType == null) {
            throw new LwcInvocableActionException(
                String.format(CLASS_DOESNT_EXIST_EXCEPTION_MESSAGE, new List<String>{ className })
            );
        }
        if (!ILwcInvocableAction.class.isAssignableFrom(classType)) {
            throw new LwcInvocableActionException(
                String.format(CLASS_ISNT_ACTION_EXCEPTION_MESSAGE, new List<String>{ className })
            );
        }
        return (ILwcInvocableAction) classType.newInstance();
    }
}
