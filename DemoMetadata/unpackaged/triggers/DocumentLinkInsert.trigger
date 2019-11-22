trigger DocumentLinkInsert on ContentDocumentLink (after insert) {
	Map<String, Schema.SObjectType> m  = Schema.getGlobalDescribe() ;
	Schema.SObjectType s = m.get('Event');
	Schema.DescribeSObjectResult r = s.getDescribe() ;
	String keyPrefix = r.getKeyPrefix();
	
    List<Event> EventToUpdate = new List<Event>();
    
    for (ContentDocumentLink e : trigger.new) { 
        if (String.valueOf(e.LinkedEntityId).substring(0,3) == keyPrefix) {
            EventToUpdate.add(new Event(id = e.LinkedEntityId, FileInsertDateTime__c = Datetime.now()));
        }                    
    }    
	update EventToUpdate;
}