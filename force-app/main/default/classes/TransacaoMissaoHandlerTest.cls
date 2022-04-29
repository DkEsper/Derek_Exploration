@isTest private class TransacaoMissaoHandlerTest {
    
    @testSetup static void MeuSetup() {
        
        //Setup (Preparação)
        Galaxia__c g = new Galaxia__c (name='Galaxia01');
        insert g;
        
        Astro__c a = new Astro__c(name = 'Astro01', Galaxia__c = g.id);
        Insert a;
        
        Espaconave__c e = new Espaconave__c(name = 'espaconave01', Consumo__c = 50000, VelocidadeDaEspaconave__c = 0.5);
    	insert e;
        
    	Missao__c m = new Missao__c(name = 'Missao01', Status__c = 'Planejamento', Origem__c = a.id, Espaconave__c = e.id, DataDeInicio__c = Date.today(), ConclusaoDaMissao__c = Date.today() + 5000); 
        insert m;   
        
        Pessoa__c p = new Pessoa__c(name = 'Pessoa01');
        insert p;  
        
        Tripulante__c t = new Tripulante__c(Pessoa__c = p.id , Missao__c = m.id, Diaria__c = 1000);
        insert t;     
    }
	
    @isTest static void TestaProcessaTransacoesSemTransacaoTripulacao() {        
        //SETUP (Preparação)                
        TransacaoMissaoHandler tmh = new TransacaoMissaoHandler([SELECT DataDeInicio__c, Origem__c, UltimoTrecho__c, Espaconave__c,                                                                        
        Status__c, DiasDaMissao__c, CustoAtualDaMissao__c, CustoDeCombustivel__c, ConclusaoDaMissao__c, DiariaDaTripulacao__c,
        PrazoDaMissao__c, AnosTripulante__c, Distancialy__c, ReceitaEspolio__c, Id, Name FROM Missao__c Limit 1]);
        
        tmh.TripulacaoAlterada = true;         
                  
        //EXECUTA
        Test.startTest();
        tmh.processaTransacoes();
        Test.stopTest();        
        
        //VALIDA
        System.assertNotEquals(null, tmh.tTripulacao);
        System.assertEquals(5000000, tmh.tTripulacao.Despesa__c);
    }
    
    
    @isTest static void TestaProcessaTransacoesComTransacaoTripulacao() {
        //SETUP (Preparação)
        Missao__c m = [SELECT DataDeInicio__c, Origem__c, UltimoTrecho__c, Espaconave__c, Status__c,                                                                       
        DiasDaMissao__c, CustoAtualDaMissao__c, CustoDeCombustivel__c, ConclusaoDaMissao__c, DiariaDaTripulacao__c,
        PrazoDaMissao__c, AnosTripulante__c, Distancialy__c, ReceitaEspolio__c, Id, Name FROM Missao__c Limit 1];
        
        m.ConclusaoDaMissao__c = Date.Today() + 3000;
        TransacaoMissaoHandler tmh = new TransacaoMissaoHandler(m);
        
        tmh.tripulacaoAlterada = true;
        Formula.recalculateFormulas(new List<SObject> {m});
                
        tmh.processaTransacoes();
		        
        //EXECUTA
        Test.startTest();
        tmh.processaTransacoes();
        Test.stopTest();   
           
         //VALIDA
        System.assertNotEquals(null, tmh.tTripulacao);
        System.assertEquals(3000000, tmh.tTripulacao.Despesa__c);
        
    }
    
}