public with sharing class DocumentGenerator {
    @AuraEnabled
    public static String generateDocument(String accountId, String title, String content) {
        AppLogger logger = LoggerService.getAppLoggerInterface();
        String contentDocumentId = '';
        try {
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
            logger.logNoteDocument(contentDocumentId);
        } catch(DmlException e) {
            logger.logException(e.getMessage());
        }
        return contentDocumentId;
    }
}
