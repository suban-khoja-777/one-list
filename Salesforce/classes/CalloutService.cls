/*
* Name : CalloutService
* Description : Utility Class for All DML Statements.
*/

public with sharing class CalloutService {
    
    /*
    * Name : doCallout
    * Description : Utility method for rest callout.
    */
    public static HTTPResponse doCallout(HttpRequest request){
        Http http = new Http();
        HTTPResponse response = http.send(request);
        return response;
    }
    
    /*
    * Name : prepareRequest
    * Description : Generate Base request for given endpoint , method , body.
    */
    public static HttpRequest prepareRequest(String endpoint , String method , String body){
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        request.setMethod(method);
        request.setBody(body);
        return request;
    }

}