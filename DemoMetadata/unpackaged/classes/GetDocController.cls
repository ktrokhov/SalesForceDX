public class GetDocController {

    @AuraEnabled
    public static List<contentDocument> getContentDocuments() {
         return [Select id,Title,FileType,CreatedBy.Name,ContentSize From contentDocument Where ContentDocument.ParentId != null LIMIT 1000];

    
    }   
 
    

    @AuraEnabled
    public static List<Event> updatePresentationTime(ID eventId){
        //public static List<Event> updatePresentationTime(DateTime t,ID eventId){
        Event event_item = [SELECT Id,Actual_Presentation_Time__c FROM Event 
                       WHERE Id= :eventId LIMIT 1];
        DateTime t1 = System.Now();
        event_item.Actual_Presentation_Time__c = t1;
        // Make the update call.
        system.debug(event_item + ' time now ' + t1);
        update event_item;
        return null;
        
    }
 	@AuraEnabled
    public static string DownloadAttachment(ID DownloadAttachmentID)
   {
    ContentDocument oldCD = [Select Id,Title FROM ContentDocument Where Id=:DownloadAttachmentID ];
    System.Debug('oldCD_Id :'+ oldCD.Id);
   // System.Debug('Old Lock :'+ oldCV.Locked__c);
    String fullFileURL = URL.getSalesforceBaseUrl().toExternalForm();
    System.Debug('fullFileURL :'+ oldCD.Id);   
    String URlDownload = fullFileURL+'/sfc/servlet.shepherd/document/download/'+oldCD.Id +'?operationContext=S1';
    system.debug('Download URL:' +URlDownload);
    return URlDownload;
    } 
    
    
}