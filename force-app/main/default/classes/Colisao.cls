public class Colisao {

    public static void calculaColisao(List<WsColisao.EspaconaveColisao> ecList)
    {
        Colisao.calculaDatasTrechos();
        List<trecho__c> trList = [SELECT id, name, destino__r.name, missao__r.espaconave__c, data__c, missao__c FROM Trecho__c WHERE Data__c <> null];
        List<missao__c> missaoColisaoList = new List<missao__c>();
        List<string> idMissaoList = new List<string>();
        for(trecho__c tr : trList) {

            for(WsColisao.EspaconaveColisao ec : ecList) {

                if(tr.Destino__r.name == ec.Planeta && tr.Data__c == ec.Data) {

                    missaoColisaoList.add(new Missao__c(id = tr.Missao__c));
                	idMissaoList.add(ec.IdMissao);
                    system.debug('############# COLISAO #############');
                    system.debug(tr);
                    system.debug(ec);
                }
            }
        }
        Colisao.SetaMissaoColisao(missaoColisaoList);
    }
    
    public static void SetaMissaoColisao(List<Missao__c> missaoList) {

        List<Tripulante__c> tripulanteList = [SELECT id, name, Pessoa__c FROM Tripulante__c WHERE Missao__c IN :missaoList];
        List<Pessoa__c> pessoaList = new List<Pessoa__c>();
        for(Tripulante__c t : tripulanteList) {

            Pessoa__c p = new Pessoa__c (id = t.Pessoa__c);
            p.Estado__c = 'Morto';
            pessoaList.add(p);
        }
        Update pessoaList;
        
        List<Missao__c> miList = [SELECT id, Espaconave__c FROM Missao__c WHERE Id IN :missaoList];
        List<Espaconave__c> EspaconaveList = new List<Espaconave__c>();
        for(Missao__c m : miList) {

            Espaconave__c e = new Espaconave__c (id = m.Espaconave__c);
            e.foiDestruida__c = true;
            EspaconaveList.add(e);
        }
        Update EspaconaveList;
        
        List<Missao__c> misList = [SELECT Id, Name FROM Missao__c WHERE Espaconave__r.foiDestruida__c = true AND DataDeInicio__c > :DATE.today()];
        for(Missao__c m : misList) {

            m.Espaconave__c = null;
        }
        Update misList;
        
        
        for(Missao__c m : missaoList) m.Status__c = 'Falha';
        Update missaoList;
    }
    
    public static void calculaDatasTrechos() {

        List<Missao__c> mList = [SELECT id, Espaconave__r.velocidadeDaEspaconave__c, dataDeInicio__c, (SELECT id, distancia__c, data__c, trechoAnterior__c FROM Trechos__r WHERE Distancia__c <> null ORDER BY createdDate ) FROM Missao__c WHERE DataDeInicio__c <> null AND Espaconave__r.velocidadeDaEspaconave__c <> null];
        List<Trecho__c> trUpdateList = new List<Trecho__c>();    
        for(missao__c m : mList) {

                List<Trecho__c> trList = m.Trechos__r;
                Date DataAnterior;
                for(Trecho__c tr : trList) {

                    if(tr.trechoAnterior__c == null) {

                        tr.data__c = m.DataDeInicio__c.addDays(Integer.valueOf(tr.distancia__c / m.Espaconave__r.velocidadeDaEspaconave__c * 365.25));
                    } 
                    
                    else {
                        tr.data__c = DataAnterior.addDays(Integer.valueOf(tr.distancia__c / m.Espaconave__r.velocidadeDaEspaconave__c * 365.25));
                    }
                    DataAnterior = tr.data__c;
                    trUpdateList.add(tr);
                }
            }
        Update trUpdateList;
    }
    
    public static void GeraColisao() {

        for(string endpoint : WsColisao.Endpoints) {

            Colisao.GeraColisao(endpoint);
        }
    }
	@future(callout = true)
	public static void GeraColisao(string endpoint) {

    	Colisao.calculaColisao(ColisaoClient.ColisaoClientCallout(endpoint));
	}
}