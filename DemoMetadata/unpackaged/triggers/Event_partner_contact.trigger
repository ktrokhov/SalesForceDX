trigger Event_partner_contact on Event (before insert, before update) {
    for(Event a : Trigger.New) {
        if (a.Partner__c != null && a.WhatId != a.Partner__c){
        	a.WhatId = a.Partner__c;
       // 	a.AccountId = a.Partner__c;
        }
        if (a.PartnerContact__c != null && a.WhoId != a.PartnerContact__c){
        	a.WhoId = a.PartnerContact__c;
        }
    }
}