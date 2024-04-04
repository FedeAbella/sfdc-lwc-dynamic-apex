/**
 * @description Represents an output object resulting from an instance of a LwcInvocableAction class
 */
public with sharing class LwcInvocableActionOutput {
    @AuraEnabled
    public Map<String, Object> result;
}
