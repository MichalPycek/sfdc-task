public with sharing class AccountListController {
    @AuraEnabled
    public static List<Account> getAccounts(List<String> accountIds) {
        String[] fieldsToCheck = new String[] {
            'Id', 'Name'
        };
        
        Map<String,Schema.SObjectField> fieldDescribeTokens = 
            Schema.SObjectType.Account.fields.getMap();
        
        for(String field : fieldsToCheck) {
            if(!fieldDescribeTokens.get(field).getDescribe().isAccessible()) {
                throw new System.NoAccessException();
            }
        }
        if(accountIds.size() > 0) {
            return [SELECT Id, Name FROM Account WHERE Id IN :accountIds ORDER BY LastModifiedDate];
        } else {
            return [SELECT Id, Name FROM Account ORDER BY LastModifiedDate];
        }
        
    }
}