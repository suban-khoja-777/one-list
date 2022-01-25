@RestResource(urlMapping='/api/v1/*')
global with sharing class ApiService{
  @HttpPost
  global static void doPost() {
    Map<String,Object> DBResponse = new Map<String,Object>();
    RestRequest request = RestContext.request;
    RestResponse response =  RestContext.response;
    Map<String, Object> requestBody = new Map<String, Object>();
    if(request.requestBody != null && String.isNotBlank(request.requestBody.toString())){
      requestBody = (Map<String, Object>) JSON.deserializeUntyped(request.requestBody.toString());
    }
    String apiName = request.requestURI.substringAfter( '/api/v1/' );
    
    switch on apiName {
      when 'getUserTasks' {
        String user_id = String.valueOf(requestBody.get('user_id'));
        String file_id = User_Mapping__mdt.getInstance('USER_'+user_id).file_id__c; 
        DBResponse = (Map<String,Object>)ApiController.getUserTasks(file_id);
      }
      when 'createTask' {
        String user_id = String.valueOf(requestBody.get('user_id'));
        String content = String.valueOf(requestBody.get('content'));
        String file_id = User_Mapping__mdt.getInstance('USER_'+user_id).file_id__c; 
        DBResponse = (Map<String,Object>)ApiController.createTask(file_id,content);
      }
      when 'updateTaskStatus' {
        String user_id = String.valueOf(requestBody.get('user_id'));
        String node_id = String.valueOf(requestBody.get('node_id'));
        Boolean checked = Boolean.valueOf(requestBody.get('checked'));
        String file_id = User_Mapping__mdt.getInstance('USER_'+user_id).file_id__c; 
        DBResponse = (Map<String,Object>)ApiController.updateTaskStatus(file_id,node_id,checked);
      }
      when 'updateTaskTitleAndNote' {
        String user_id = String.valueOf(requestBody.get('user_id'));
        String node_id = String.valueOf(requestBody.get('node_id'));
        String note = String.valueOf(requestBody.get('note'));
        String content = String.valueOf(requestBody.get('content'));
        String file_id = User_Mapping__mdt.getInstance('USER_'+user_id).file_id__c; 
        DBResponse = (Map<String,Object>)ApiController.updateTaskTitleAndNote(file_id,node_id,content,note);
      }
      when 'deleteTask' {
        String user_id = String.valueOf(requestBody.get('user_id'));
        String node_id = String.valueOf(requestBody.get('node_id'));
        String file_id = User_Mapping__mdt.getInstance('USER_'+user_id).file_id__c; 
        DBResponse = (Map<String,Object>)ApiController.deleteTask(file_id,node_id);
      }
    }

    response.addHeader('Content-Type','application/json');
    response.addHeader('Access-Control-Allow-Origin',System.Label.Origin);
    response.statuscode = 200;
      
    response.responseBody = Blob.valueOf(JSON.serialize(DBResponse));
  } 
}
