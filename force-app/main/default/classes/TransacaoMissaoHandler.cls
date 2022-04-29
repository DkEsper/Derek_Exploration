public class TransacaoMissaoHandler {
    
    //Atributos (Caractristicas)
	public Missao__c missao;
    public Transacao__c tTripulacao; 
    public Transacao__c tEspolio;
    public Transacao__c tConsumo;
    public boolean tripulacaoAlterada; //Setado na trigger, mais facil para ver se um campo foi alterado na trigger
    public boolean espolioAlterado;	   //Setado na trigger, mais facil para ver se um campo foi alterado na trigger	
    public boolean consumoAlterado;	   //Setado na trigger, mais facil para ver se um campo foi alterado na trigger
    
	//Metodos  (Comportamentos)
	
	//Metodo Construtor (Sempre tem o mesmo nome da classe, ele não precisa de retorno pois não retorna nada)
	
    public transacaoMissaoHandler(Missao__c m) {
        this.missao = m;	//(this) significa que está pegando uma variavel da propria classe		
        this.pesquisaTransacaoMissao();         
    }
    
    public void processaTransacoes() {
        if(this.tripulacaoAlterada) {
            
            if(tTripulacao == null) {
                
                tTripulacao = new Transacao__c(); //Instanciando um objeto = reservar um espaço de memoria para guardar informações
                tTripulacao.Despesa__c = missao.CustoAtualDaMissao__c;
                tTripulacao.Tipo__c = 'Tripulação';
                tTripulacao.Missao__c = missao.id;
                tTripulacao.RecordTypeId = Schema.SObjectType.Transacao__c.getRecordTypeInfosByName().get('Despesa').getRecordTypeId();
                tTripulacao.Status__c = 'Prevista';         
            }
            else{
                tTripulacao.Despesa__c = missao.CustoAtualDaMissao__c;
                
            }
        }
    }
    
    //Modificador / retorno nomeDoMetodo(tipo nome, tipo nome, tipo nome)
    
    public void atualizaTransacaoMissaoConcluida() {
        this.tEspolio.Status__c = 'Executada';
        this.tTripulacao.Status__c = 'Executada';  
    }
    
    public void atualizaTransacaoMissaoEmExecucao() {
        this.tConsumo.Status__c = 'Executada';        
    }
    
    public void atualizaTransacaoMissaoEmFalha() {
        this.tEspolio.Status__c = 'Cancelada';
        this.tTripulacao.Status__c = 'Cancelada';       
    }
     
    public void pesquisaTransacaoMissao() {
        List<Transacao__c> TransacaoMissaoList = [SELECT id, name, Tipo__c, Despesa__c, 
        recordTypeId, Receita__c from Transacao__c where Missao__c = : missao.id];
        for (Transacao__c t : TransacaoMissaoList) {
            
            if(t.Tipo__c == 'Tripulação') this.tTripulacao = t;
            if(t.Tipo__c == 'Consumo') this.tConsumo = t;            
            if(t.Tipo__c == 'Espolio') this.tEspolio = t;
        }
    } 
}