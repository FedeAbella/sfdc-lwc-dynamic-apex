/**
 * @description Represents a response resulting from running an instance of a LwcInvocableAction class
 */
public with sharing class LwcInvocableActionResponse {
    @AuraEnabled
    public Boolean success;
    @AuraEnabled
    public Map<String, Object> result;
    @AuraEnabled
    public List<String> errors;
}
