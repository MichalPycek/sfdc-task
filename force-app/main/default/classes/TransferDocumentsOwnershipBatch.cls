global class TransferDocumentsOwnershipBatch implements Database.Batchable<sObject> {
	Map<Id, List<ContentDocumentLink>> documentIdWithContentDocumentLinks = new Map<Id, List<ContentDocumentLink>>();
	Map<Id, User> allClerks = new Map<Id, User>();
	global TransferDocumentsOwnershipBatch(Map<Id, List<ContentDocumentLink>> documentIdWithContentDocumentLinks, Map<Id, User> allClerks) {
		this.documentIdWithContentDocumentLinks = documentIdWithContentDocumentLinks;
		this.allClerks = allClerks;
	}

	global Database.QueryLocator start(Database.BatchableContext BC) {
		Set<Id> documentIds = documentIdWithContentDocumentLinks.keySet();
		String query = 'SELECT Id, OwnerId FROM ContentDocument WHERE Id IN :documentIds';
		return Database.getQueryLocator(query);
	}

	global void execute(Database.BatchableContext BC, List<ContentDocument> scope) {
		for (ContentDocument cd : scope) {
			for(ContentDocumentLink cdl : documentIdWithContentDocumentLinks.get(cd.Id)) {
				if(cd.OwnerId == allClerks.get(cdl.LinkedEntityId).Id) {
					cd.OwnerId = allClerks.get(cdl.LinkedEntityId).ManagerId;
				}
			}
		}
		update scope;
	}

	global void finish(Database.BatchableContext BC) {
	}
}