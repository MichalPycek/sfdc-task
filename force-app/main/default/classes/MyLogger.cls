public class MyLogger implements AppLogger {
    public void logException(String ex) {
        System.debug('My Exception ' + ex);
    }

    public void logNoteDocument(String contentDocumentId) {
        System.debug('My Note Document ' + contentDocumentId);
    }
}