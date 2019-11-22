public class PartnerIndexController {
    
    @AuraEnabled
    public static List<PartnerIndex__c> getPartnerIndex(ID accId) {
        
        return [SELECT id,IndexShortDate__c,Name,IndexDate__c,
                PeriodSalesVolumePlan__c, PeriodSalesVolumeFact__c,
                PercentSalesVolumeFact__c, PeriodSalesVolumeInvestFact__c, PeriodSalesVolumeInvestPlan__c FROM PartnerIndex__c WHERE Account__c	 = :accId ORDER BY IndexDate__c];
        
        
    }  

    @AuraEnabled
    public static List<PartnerIndex__c> getPartIndNow(ID accId) {
        Date qwe = System.today();
        return [SELECT id,IndexShortDate__c,Name,IndexDate__c,
                PeriodSalesVolumePlan__c, PeriodSalesVolumeFact__c,
                PercentSalesVolumeFact__c, PeriodSalesVolumeInvestFact__c, PeriodSalesVolumeInvestPlan__c FROM PartnerIndex__c WHERE (Account__c = :accId AND CALENDAR_YEAR(IndexDate__c)=:qwe.year()) ORDER BY IndexDate__c LIMIT 12];
 
    } 

     @AuraEnabled
    public static List<PartnerIndex__c> getPartIndAll(ID accId) {
        return [SELECT id,IndexShortDate__c,Name,IndexDate__c,
                PeriodSalesVolumePlan__c, PeriodSalesVolumeFact__c,
                PercentSalesVolumeFact__c, PeriodSalesVolumeInvestFact__c, PeriodSalesVolumeInvestPlan__c FROM PartnerIndex__c WHERE Account__c = :accId  ORDER BY IndexDate__c ];
 
    }
    


    
    @AuraEnabled
    public static List<PartnerIndex__c>  createPartnerIndex (ID accId) {
        Date qwe = System.today();
        Integer currentYearI =  System.Today().year();
        String currentYearS = String.valueOf(currentYearI);
        // Date currentYear = Date.newInstance(currentYearS, '1', '1');
        List<PartnerIndex__c>  oldpartnerList = [SELECT id,IndexShortDate__c,Name, IndexDate__c,
                                                 PeriodSalesVolumePlan__c, PeriodSalesVolumeFact__c,
                                                 PercentSalesVolumeFact__c,PeriodSalesVolumeInvestFact__c, PeriodSalesVolumeInvestPlan__c, Account__c FROM PartnerIndex__c WHERE (Account__c = :accId AND CALENDAR_YEAR(IndexDate__c)=:qwe.year()) ORDER BY IndexDate__c LIMIT 12]; 
        
        //system.debug('old: ' + oldpartnerList);
        
        if (oldpartnerList.IsEmpty()){
		
        Date newdate = date.newInstance(System.today().year(), 1, 1);
        List<PartnerIndex__c> newpartnerList = new List<PartnerIndex__C>();
        	
            
            PartnerIndex__c p1 = new PartnerIndex__c(Account__c = accId, IndexDate__c = newdate.addMonths(0));
            PartnerIndex__c p2 = new PartnerIndex__c(Account__c = accId, IndexDate__c = newdate.addMonths(1));
            PartnerIndex__c p3 = new PartnerIndex__c(Account__c = accId, IndexDate__c = newdate.addMonths(2));
            PartnerIndex__c p4 = new PartnerIndex__c(Account__c = accId, IndexDate__c = newdate.addMonths(3));
            PartnerIndex__c p5 = new PartnerIndex__c(Account__c = accId, IndexDate__c = newdate.addMonths(4));
            PartnerIndex__c p6 = new PartnerIndex__c(Account__c = accId, IndexDate__c = newdate.addMonths(5));
            PartnerIndex__c p7 = new PartnerIndex__c(Account__c = accId, IndexDate__c = newdate.addMonths(6) );
            PartnerIndex__c p8 = new PartnerIndex__c(Account__c = accId, IndexDate__c = newdate.addMonths(7));
            PartnerIndex__c p9 = new PartnerIndex__c(Account__c = accId, IndexDate__c = newdate.addMonths(8));
            PartnerIndex__c p10 = new PartnerIndex__c(Account__c = accId, IndexDate__c = newdate.addMonths(9));
            PartnerIndex__c p11 = new PartnerIndex__c(Account__c = accId, IndexDate__c = newdate.addMonths(10));
            PartnerIndex__c p12 = new PartnerIndex__c(Account__c = accId, IndexDate__c = newdate.addMonths(11));
           	
        	newpartnerList.add(p1);
            newpartnerList.add(p2);
            newpartnerList.add(p3);
            newpartnerList.add(p4);
            newpartnerList.add(p5);
            newpartnerList.add(p6);
            newpartnerList.add(p7);
            newpartnerList.add(p8);
            newpartnerList.add(p9);
            newpartnerList.add(p10);
            newpartnerList.add(p11);
            newpartnerList.add(p12);
            
            insert newpartnerList;
   
        }else
        {
          // System.debug('not empty');  
        }

        
        Date qwe1 = qwe.addYears(1);
        
        List<PartnerIndex__c>  nextypartnerList = [SELECT id,IndexShortDate__c,Name, IndexDate__c,
                                                   PeriodSalesVolumePlan__c, PeriodSalesVolumeFact__c,
                                                   PercentSalesVolumeFact__c,PeriodSalesVolumeInvestFact__c, PeriodSalesVolumeInvestPlan__c, Account__c FROM PartnerIndex__c WHERE (Account__c = :accId AND CALENDAR_YEAR(IndexDate__c)=:qwe1.year()) ORDER BY IndexDate__c LIMIT 12]; 
        
        
        if (nextypartnerList.IsEmpty())
        {
            List <PartnerIndex__c> newpartnerList = new  List<PartnerIndex__c>();
            
            for (PartnerIndex__c item : oldpartnerList){
                PartnerIndex__c newItem = new PartnerIndex__c();
                newItem.IndexDate__c = item.IndexDate__c.addYears(1);
                //newItem.IndexShortDate__c = item.IndexShortDate__c;
                newItem.PeriodSalesVolumePlan__c = item.PeriodSalesVolumePlan__c;
                newItem.Account__c = item.Account__c;
                newpartnerList.add(newItem);
            }
            //system.debug('new: ' + newpartnerList);
            insert newpartnerList;
            
        }
        else
        {
           // System.debug('not empty');
        }
        
        
        
        return [SELECT id,IndexShortDate__c,Name,IndexDate__c,
                PeriodSalesVolumePlan__c, PeriodSalesVolumeFact__c,
                PercentSalesVolumeFact__c,PeriodSalesVolumeInvestFact__c, PeriodSalesVolumeInvestPlan__c FROM PartnerIndex__c WHERE Account__c	 = :accId ORDER BY 	IndexDate__c]; 
        
    }   
    
    @AuraEnabled
    public static List<PartnerIndex__c> getIndex(ID partnerId) {
        
        return [SELECT Reason__c, PeriodSalesVolumePlan__c FROM PartnerIndex__c WHERE Id = :partnerId];
    }
    
    @AuraEnabled
    public static boolean upsertIndex(List<PartnerIndex__c> IndexList){
        //System.debug('index: ' + IndexList[0]);
        PartnerIndex__c qwe = IndexList[0];
        System.debug('reason= ' + qwe);
        if (qwe.Reason__c == NULL)
        {
            return false;
        }
        else
        {
            try{
                upsert IndexList;
                return true;
            } catch(Exception e){
                return false;
            } 
            
        }
        
    }
    
    
}