global class ClassificadoraSchedulable implements Schedulable {
    
    global void execute(SchedulableContext SC) {  
        
       Database.executeBatch(new ClassificadorBatchable(), 666);
    }
 }
 