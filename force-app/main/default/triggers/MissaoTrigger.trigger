trigger MissaoTrigger on Missao__c (after update) {
    
    List<Transacao__c> TransacoesUpdateList = new List<Transacao__c>();
        
    for(Missao__c mi : Trigger.new) {	
        
        TransacaoMissaoHandler tmh = new TransacaoMissaoHandler(mi);
        tmh.tripulacaoAlterada = mi.CustoAtualDaMissao__c != trigger.oldMap.get(mi.id).	CustoAtualDaMissao__c;
        tmh.processaTransacoes();
        TransacoesUpdateList.add(tmh.tTripulacao);
    }
    if(TransacoesUpdateList.size() > 0) {
         UPSERT TransacoesUpdateList;	
    }
 }