public class ColisaoClient {
    
	public static List<WsColisao.EspaconaveColisao> ColisaoClientCallout(String endpoint){
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        
        //If the request is sucessful, parse the JSON response
        if(response.getStatusCode() == 200) {

			//Deserialise the JSON string into colletctions of primitive data types              
            List<WsColisao.EspaconaveColisao> colision = (List<WsColisao.EspaconaveColisao>)JSON.deserialize(response.getBody(), List<WsColisao.EspaconaveColisao>.class);
            system.debug(colision);
            System.debug(colision[0].nome);
            return colision;            
        }        
        return null;
    }
}