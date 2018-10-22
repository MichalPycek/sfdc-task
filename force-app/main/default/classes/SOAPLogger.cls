public class SOAPLogger implements AppLogger {
    public void logException(String ex) {   
        System.debug('SOAP Exception ' + ex);
    }

    public void logNoteDocument(String contentDocumentId) {
        System.debug('SOAP Note Document ' + contentDocumentId);
    }
}