public class OpportunityHelper {
    public static void createChildOpportunity(List<Opportunity> opps, Map<Id, Opportunity> oldMap) {
        List<Opportunity_Account__c> qwe = [SELECT Id, Account__c, Opportunity__c 
                                            FROM Opportunity_Account__c 
                                            WHERE Opportunity__c =: opps];
        List<Opportunity> oppsNew = new List<Opportunity>();
        List<Opportunity_Account__c> oasNew = new List<Opportunity_Account__c>();
        
        for(Opportunity opp : opps){
            if (opp.StageName == 'Лизинг' &&  oldMap.get(opp.Id).StageName == 'Продажа'){
                for (Opportunity_Account__c qw : qwe){
                    Opportunity oppNew = new Opportunity(
                        Name = opp.Name + ' Лизинг',
                        StageName = 'Рассчитано',
                        RecordTypeId = '0122p000000VgS6AAK',
                        CloseDate = opp.CloseDate,
                        Account__c = qw.Account__c,
                        Opportunity_Parent__c = qw.Opportunity__c
                    );
                    oppsNew.add(oppNew);
                }
            }
        }
        if (oppsNew.size()>0){
            insert oppsNew;
        }
        for(Opportunity opp : oppsNew){
            System.debug('opp=' + opp.Id);
        }
    }
    public static void createJunk(List<Opportunity> opps){
        List<Opportunity_Account__c> newJnks = new List<Opportunity_Account__c>();
        for(Opportunity opp : opps){
            Opportunity_Account__c newJnk = new Opportunity_Account__c (
                Opportunity__c = opp.Id,
                Account__c = opp.Account__c
            );
            newJnks.add(newJnk);
        }
        if (newJnks.size()>0){
            insert newJnks;
        }
    }
    
    public static void createNewTask(List<Opportunity> opps, Map<Id, Opportunity> oldMap){
        List<Task> listOfTasks = new List<Task>();  
        for(Opportunity opp : opps){
            if (opp.StageName == 'Лизинг' && oldMap.get(opp.Id).StageName == 'Продажа'){
                Task newTask = new Task(
                    Subject = 'Возможность перешла на этал "Лизинг"',
                    Priority = 'Normal',
                    Status = 'Not Started',
                    OwnerId  = opp.OwnerId,
                    WhatId = opp.Id
                );
                listOfTasks.add(newTask);
            }
        }
        if (listOfTasks.size()>0){
            insert listOfTasks;   
        }
    }
    
    public static void createNewTaskFromEmail(List<Opportunity> opps, User usr){
        List<Task> listOfTasks = new List<Task>();  
        for(Opportunity opp : opps){
            Task newTask = new Task(
                Subject = 'Email: Подтвержение скидки. Письмо отправлено пользователю ' + usr.Name + ' на адрес ' + usr.Email,
                Priority = 'Normal',
                Status = 'Not Started',
                OwnerId  = opp.OwnerId
            );
            listOfTasks.add(newTask);
        }
        if (listOfTasks.size()>0){
            insert listOfTasks;   
        }
    }
    public static void createNewAssets(List<Opportunity> opps){
        List<OpportunityLineItem> oppLines = [SELECT Id, Name, Product2Id, Product2.VIN__c, 
                                              Product2.Condition__c, Product2.Production_year__c, Quantity, UnitPrice
                                              FROM OpportunityLineItem 
                                              WHERE OpportunityId =: opps];
        if(oppLines!=null && !oppLines.isEmpty()){
            List<Id> listId= new List<Id>();
            for (Opportunity opp: opps){
                listId.add(opp.AccountId);
            }
            List<Account> accs = [SELECT Name FROM Account WHERE Id =: listId];
            
            List<Asset> assetsToInsert = new List<Asset>();
            for(Opportunity opp : opps){
                if (opp.StageName == 'Успешно реализовано' && opp.IsWon == true){
                    for (OpportunityLineItem oppLine : oppLines){
                        for (Integer i = 0; i < oppLine.Quantity; i++){
                            for(Account acc : accs){
                                if(acc.Id == opp.AccountId){
                                    Asset  newAsset = new Asset (
                                        Name = acc.Name,
                                        AccountId = opp.AccountId,
                                        Product2Id = oppLine.Product2Id,
                                        Quantity = 1,
                                        Price = oppLine.UnitPrice,
                                        VIN__c = oppLine.Product2.VIN__c,
                                        car_state__c = oppLine.Product2.Condition__c,
                                        car_take__c = opp.date_take__c,
                                        end_date__c = opp.CloseDate,
                                        prod_year__c = oppLine.Product2.Production_year__c
                                    );
                                    assetsToInsert.add(newAsset);
                                }
                            }
                        }
                    }
                }
            }
            if (assetsToInsert.size()>0){
                insert assetsToInsert;
            }
        }
        
        
    }
}