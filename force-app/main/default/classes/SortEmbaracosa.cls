public  class SortEmbaracosa {

    List<Astro__c> AstrosFromDatabase = [SELECT id, name, Massa__c FROM Astro__c];
    List<Astro__c> SortedList;

    public List<Astro__c> executeSort() {
        
        SortedList = AstrosFromDatabase.clone();
        boolean houveTroca;
        do {
            houveTroca = false;
            for(Integer i = 0; i <SortedList.size()-1; i++) {

                Astro__c = aux;
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
        return SortedList;
  }  
}
