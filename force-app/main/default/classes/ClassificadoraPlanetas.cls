public class ClassificadoraPlanetas {
	
    public static void classificaAstros() {
       List<Astro__c> AstrosFromDatabase = [SELECT id, name, Massa__c FROM Astro__c ];
        
        for(Astro__c a : AstrosFromDatabase) {
            
            if(a.Massa__c <= 1) {                
                a.Tipo__c = 'Mini Anão';
            }
            else {
                if(a.Massa__c <= 10) {
                    a.Tipo__c = 'Anão';
                }
                
                else {
                    if(a.Massa__c <= 100) {
                        a.Tipo__c = 'Médio';
                }
                    else {
                		if(a.Massa__c <= 1000) {
                    	a.Tipo__c  = 'Gigante';
                	}                        
                       else {                			
                    		a.Tipo__c = 'Super Gigante';

                       }  
                    }                            
                }
            }
        }
    }
}