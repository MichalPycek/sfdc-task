global class TransferDocumentsOwnership implements Schedulable {
	global void execute(SchedulableContext SC) {
		Map<Id, User> allClerks = new Map<Id, User>([SELECT Id, ManagerId FROM User WHERE ManagerId != null]);
		Set<Id> allClerksIds = allClerks.keySet();
		Map<Id, List<ContentDocumentLink>> documentIdWithContentDocumentLinks = new Map<Id, List<ContentDocumentLink>>();
		for(ContentDocumentLink cdl : [SELECT ContentDocument.OwnerId, LinkedEntityId, ContentDocumentId FROM ContentDocumentLink WHERE LinkedEntityId IN :allClerksIds AND ContentDocument.CreatedDate < LAST_N_DAYS:3]) {
			if(documentIdWithContentDocumentLinks.containsKey(cdl.ContentDocumentId)) {
				List<ContentDocumentLink> cdlList = documentIdWithContentDocumentLinks.get(cdl.ContentDocumentId);
				cdlList.add(cdl);
				documentIdWithContentDocumentLinks.put(cdl.ContentDocumentId, cdlList);
			} else {
				documentIdWithContentDocumentLinks.put(cdl.ContentDocumentId, new List<ContentDocumentLink> { cdl });
			}
		}
		TransferDocumentsOwnershipBatch transferDocumentsBatch = new TransferDocumentsOwnershipBatch(documentIdWithContentDocumentLinks, allClerks);
		database.executeBatch(transferDocumentsBatch);
	}
}
