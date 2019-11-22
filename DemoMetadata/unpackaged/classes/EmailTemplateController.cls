public with sharing class EmailTemplateController {
    @AuraEnabled 
    public static void sendEmail1(String idOpp){
        EmailTemplate et = [SELECT Id, Subject, Body FROM EmailTemplate WHERE DeveloperName = 'DealerEmailTemplate'];
        //Contact con = [SELECT Id,Name FROM Contact WHERE Id='0032p00002bDGp0AAG'];
        Opportunity accId = [SELECT AccountId FROM Opportunity WHERE Id =:idOpp LIMIT 1];
        Account ownerId = [SELECT OwnerId FROM Account WHERE Id =: accId.AccountId];
        User usrEmail = [SELECT Id,Name,Email FROM User WHERE Id =: ownerId.OwnerId];

        List<String> toAddress = new List<String>();
        Id userId = UserInfo.getUserId();
        User usr = [SELECT Id, Name FROM User WHERE Id =: userId];
        //toAddress.add(primaryEmail);
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setTemplateId(et.Id);
        //mail.setToAddresses(toAddress);
        //mail.setSubject(et.subject);
        mail.setHTMLBody(et.Body);
        mail.setTargetObjectId(usrEmail.Id);
        mail.setWhatId(usrEmail.Id);
        mail.setSaveAsActivity(false);
        //mail.setUseSignature(false);
        List<Messaging.SingleEmailMessage> allmsg = new List<Messaging.SingleEmailMessage>();
        allmsg.add(mail);
        
        //EmailTemplate template = [SELECT Id, Subject, HtmlValue, Body FROM EmailTemplate WHERE Name = 'Case Update'];
        //Case modifiedCase = [SELECT Account.Id, Account.Name, Owner.FirstName, Owner.LastName, CaseNumber, Subject, LastModifiedBy.FirstName,  LastModifiedBy.LastName from Case where Id=:modifiedCaseId];
        
        //String subject = et.Subject;
        //subject = subject.replace('{!Contact.Name}', con.Name);
        
        String Body = et.Body;
        Body = Body.replace('{!Contact.Name}', usrEmail.Name);
        Body = Body.replace('{!User.Name}', usr.Name);
            
        mail.setSubject(et.subject);
        mail.setPlainTextBody(Body);
        mail.setHTMLBody(null);

        
        
        try {
            Messaging.sendEmail(allmsg,false);
            List<Opportunity> qwe = [SELECT Id, Name, OwnerId FROM Opportunity WHERE Id =: idOpp];
            OpportunityHelper.createNewTaskFromEmail(qwe, usrEmail);
            return;
        } catch (Exception e) {
            System.debug(e.getMessage());
        }
        
    }
}