TransferDocumentsOwnership transferFiles = new TransferDocumentsOwnership();
String sch = '0 0 22 * * ? *';
String jobID = System.schedule('Transfer Files', sch, transferFiles);