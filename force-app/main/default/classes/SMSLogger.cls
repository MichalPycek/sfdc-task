public class SMSLogger implements AppLogger {
    public void logException(String ex) {
        System.debug('SMS Exception ' + ex);
    }

    public void logNoteDocument(String contentDocumentId) {
        System.debug('SMS Note Document ' + contentDocumentId);
    }
}