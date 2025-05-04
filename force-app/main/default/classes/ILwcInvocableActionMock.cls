@isTest
public class ILwcInvocableActionMock implements ILwcInvocableAction {
    public enum RUN_RESULT {
        SUCCESS,
        FAILED,
        ERROR
    }

    @testVisible
    private static final String RUN_ERROR_EXCEPTION_MESSAGE = 'Something went wrong with the run() method';

    @testVisible
    private static final String RUN_FAILED_ERROR_MESSAGE = 'The action failed but did not throw an Exception';

    @testVisible
    private static RUN_RESULT result = RUN_RESULT.SUCCESS;

    /**
     * @description Mock method for ILwcInvocableAction implementations. Disregards arguments and returns an
     * LwcInvocableActionResponse object with the passed input and options, or throw an exception, depending on the parent
     * instance's value of the private result variable.
     * @param input a map of string keys to object values. Disregarded in the mock method.
     * @param options a map of string keys to object values. Disregarded in the mock method.
     * @return an LwcInvocableActionResponse object with the passed input and options.
     */
    public LwcInvocableActionResponse run(Map<String, Object> input, Map<String, Object> options) {
        switch on (result) {
            when SUCCESS {
                LwcInvocableActionResponse response = new LwcInvocableActionResponse();
                response.success = true;
                Map<String, Object> result = new Map<String, Object>();
                result.put('input', input);
                result.put('options', options);
                response.result = result;
                return response;
            }
            when FAILED {
                LwcInvocableActionResponse response = new LwcInvocableActionResponse();
                response.success = false;
                response.errors = new List<String>{ RUN_FAILED_ERROR_MESSAGE };
                return response;
            }
            when ERROR {
                throw new LwcInvocableActionException(RUN_ERROR_EXCEPTION_MESSAGE);
            }
        }
        return null;
    }
}
