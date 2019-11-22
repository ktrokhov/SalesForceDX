public class EventDocs {
    private String sortOrder = 'PathOnClient';
        
    public List<ContentVersion> getContentDocuments() {
        List<ContentVersion> results = Database.query(
            'SELECT Id, Title, PathOnClient, FileExtension, FirstPublishLocationId, ContentDocumentId, ContentDocument.ContentAssetId' +
            'FROM ContentVersion ' +
            'Where ContentDocument.ParentId != null ' +
            'ORDER BY ' + sortOrder + ' ASC ' +
            'LIMIT 10'
        );
    	return results;
	}
   
    
    public pageReference updatePresentationTime(DateTime t,ID eventId){
        Event event = [SELECT Id,Actual_Presentation_Time__c FROM Event 
                       WHERE Id= :eventId LIMIT 1];
        event.Actual_Presentation_Time__c = t;
        // Make the update call.
        update event;
        return null;
    }
    
}