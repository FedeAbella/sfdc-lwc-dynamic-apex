/**
 * @description Interface for implementing Dynamic Actions invocable from LWCs
 */
public interface ILwcInvocableAction {
    /**
     * @description Method that is called in an implementing class when the action is requested
     * from a LWC
     * @param input a Map of string keys to object values, representing the variable input arguments
     * passed to the action
     * @return an instance of LwcInvocableActionResponse with the results of the action
     */
    LwcInvocableActionResponse run(Map<String, Object> input);

    /**
     * @description Method that is called in an implementing class when the action is requested
     * from a LWC
     * @param input a Map of string keys to object values, representing the variable input arguments
     * passed to the action
     * @param options a Map of string keys to object values, representing options passed to the
     * implementing action to modify its behaviour
     * @return an instance of LwcInvocableActionResponse with the results of the action
     */
    LwcInvocableActionResponse run(Map<String, Object> input, Map<String, Object> options);
}
