@RestResource(urlMapping ='/DerekColision')

global class WsColisao{
    
    @HttpGet
    global static List<EspaconaveColisao> ListaTrechosColisao(){
        
        List<trecho__c> trList = [SELECT id, name, destino__r.name, missao__r.espaconave__r.name, data__c, missao__c FROM trecho__c WHERE data__c <> null];
        List<EspaconaveColisao> ecList = new List<EspaconaveColisao>();
        for(trecho__c tr : trList)
         {
            EspaconaveColisao ec = new EspaconaveColisao();
			ec.nome = 'Derek';
        	ec.Espaconave = tr.missao__r.espaconave__r.name;
        	ec.Planeta = tr.destino__r.name;
        	ec.Data = tr.Data__c;
            ec.IdMissao = tr.missao__c;
            ecList.add(ec);
         }
        
        
        return ecList;
    }
    
    global class EspaconaveColisao{
        
        public String nome;
        public String Espaconave;
        public String Planeta;
        public Date Data;
        public String IdMissao;  	
    }
    
    public static List<String> endpoints = new List<String> {'',''};
    }