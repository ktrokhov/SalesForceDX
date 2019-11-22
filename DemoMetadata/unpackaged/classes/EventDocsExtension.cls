public class EventDocsExtension {
  private String sortOrder = 'PathOnClient';
    
  private final Event evt;

  public EventDocsExtension(ApexPages.StandardController stdController) {
  this.evt = (Event)stdController.getRecord();
	}   
    
   
    public  List<ContentVersion> getContentDocuments() {

        List<ContentVersion> results = Database.query(
            'SELECT Id, Title, PathOnClient, FileExtension, FirstPublishLocationId, ContentDocumentId, ContentDocument.ContentAssetId ' +
            'FROM ContentVersion ' +
            'Where ContentDocument.ParentId != null ' +
            'ORDER BY ' + sortOrder + ' ASC ' +
            'LIMIT 10'
        );
    	return results;
	}
    
     
}