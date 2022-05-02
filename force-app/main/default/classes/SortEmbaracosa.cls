public  class SortEmbaracosa {   

    @future public static void executeSort() {
        
         List<Astro__c> AstrosFromDatabase = [SELECT id, name, Massa__c FROM Astro__c LIMIT 1000];
   		 List<Astro__c> SortedList;
        
        SortedList = AstrosFromDatabase.clone();
        boolean houveTroca;

        do {
            
            houveTroca = false;
            for(Integer i = 0; i < SortedList.size() -1; i++) {

                Astro__c aux;
                Double atual = SortedList.get(i).Massa__c;
                Double posterior = SortedList.get(i+1).Massa__c;

            if(Atual > posterior) {

                aux = SortedList[i];                
                SortedList[i] = SortedList[i+1];
                SortedList[i+1] = aux;
                houveTroca = true;
            }            
        }
    }   
        while(houveTroca);
        //return SortedList;
  }  
}