public class ClassificadorBatchable implements Database.Batchable<sObject> {  

    public Database.QueryLocator start(Database.BatchableContext BC) {
        
       return Database.getQueryLocator('SELECT id, name, Massa__c FROM Astro__c');
        }
 
     public void execute(Database.BatchableContext BC, List<Astro__c> astros) {
         for(Astro__c a : astros) { 
             
                ClassificadoraPlanetas.classificaAstro(a);              
          }
         update astros;
         System.debug('DML EXECUTADO = ' + System.Limits.getDMLRows());
         System.debug('DML EXECUTADO = ' + System.Limits.getLimitDMLRows());
     }    
        
     public void finish(Database.BatchableContext BC) {        
            
     }
 }