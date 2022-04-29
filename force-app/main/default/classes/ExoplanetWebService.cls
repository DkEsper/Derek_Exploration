public class ExoplanetWebService {

    public static void PopulaAstros() {
        
    Http http = new Http(); //Instanciando meu objeto HTTP
    HttpRequest request = new HttpRequest(); //Instanciando o meu objeto request
    String endpoint = Integracao__mdt.getInstance('EXPL').endpoint__c;
    request.setEndpoint(endpoint+'?query=select+pl_name+,+pl_bmasse+from+pscomppars&format=json');
    request.setMethod('GET');
    HttpResponse response = http.send(request); //ESSA LINHA QUE FAZ A PORRA TODA ACONTECER!!!!!!!
    // If the request is successful, parse the JSON response.
    if(response.getStatusCode() == 200) { 
        // Deserialize the JSON string into collections of primitive data types.         
        List<Object> results = (List<Object>) JSON.deserializeUntyped(response.getBody());
        system.debug(results.size());
        List<Astro__c> astrList = new List<Astro__c>();
        for(Object expl : results) { 
            	
            Astro__c astr = new Astro__c();
            Map<String,Object> expl2 = (Map<String,Object>) expl;
            astr.Name = (String)expl2.get('pl_name');
            astr.Massa__c = (Decimal)expl2.get('pl_bmasse');
            astr.Galaxia__c = 'a008b00001F4KcJAAV';
            astrList.add(astr);
        }
        insert astrList;
    }	
        /*else {
            throw new CalloutException(); // LANÇANDO UMA EXCESSÃO*/
        }          
     }