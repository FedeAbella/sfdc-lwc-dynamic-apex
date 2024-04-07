/**
 * @description Represents a request for an LWC to an LwcInvocableAction class to perform an action
 */
public with sharing class LwcInvocableActionRequest {
    @AuraEnabled
    public Map<String, Object> input;

    @AuraEnabled
    public Map<String, Object> options;
}
