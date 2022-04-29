public class ContaTripulante {
    
    public static integer tripulacaoMissao(Missao__c m){
        
        List<Tripulante__c> listTrp = [SELECT id, Name FROM Tripulante__c WHERE Missao__r.id = :m.id];
        
        return listTrp == null ? 0 : listTrp.size();
    }
}