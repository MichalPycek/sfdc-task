public with sharing class DocumentGenerator {
    @AuraEnabled
    public static String generateDocument(String accountId, String title, String content) {
        AppLogger logger = LoggerService.getAppLoggerInterface();
        String contentDocumentId = '';
        try {
            String managerId = [SELECT Id, ManagerId FROM User WHERE Id = :UserInfo.getUserId()].ManagerId;
            ContentVersion contentv = new ContentVersion(
                VersionData = Blob.valueOf(content),
                PathOnClient = title + '.txt');
            INSERT contentv;
            contentDocumentId = [SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id = :contentv.Id].ContentDocumentId;
            if(String.IsNotBlank(accountId)) {
                ContentDocumentLink contentLink = new ContentDocumentLink();
                contentLink.LinkedEntityId = accountId;
                contentLink.ShareType = 'V';
                contentLink.ContentDocumentId = contentDocumentId;
                INSERT contentLink;
            }
            if(String.IsNotBlank(managerId)) {
                ContentDocumentLink contentManagerLink = new ContentDocumentLink();
                contentManagerLink.LinkedEntityId = managerId;
                contentManagerLink.ShareType = 'C';
                contentManagerLink.ContentDocumentId = contentDocumentId;
                INSERT contentManagerLink;
            }
            logger.logNoteDocument(contentDocumentId);
        } catch(DmlException e) {
            logger.logException(e.getMessage());
        }
        return contentDocumentId;
    }
}
