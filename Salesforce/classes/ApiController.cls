global with sharing class ApiController{

    public static Object getUserTasks(String file_id){
        Api_Info__mdt endpointPath = Api_Info__mdt.getInstance('getUserTasks'); 
        Map<String,Object> requestValues = new Map<String,Object>();
        requestValues.put('file_id',file_id); 
        Map<String,Object> externalRequestBody = ApiRequestUtility.generateRequest('getUserTasks',requestValues);
        HttpRequest request = CalloutService.prepareRequest(
            'callout:Dynalist'+endpointPath.MasterLabel,
            endpointPath.contentType__c,
            JSON.serialize(externalRequestBody)
        );

        HTTPResponse response =  CalloutService.doCallout(request);
        Map<String,Object> responseMap = new Map<String,Object>();
        if(response != null && String.isNotBlank(response.getBody()) && response.getStatusCode() == 200){
            responseMap = (Map<String,Object>)JSON.deserializeUntyped(response.getBody());
            List<Object> nodes = (List<Object>)responseMap.get('nodes');
            if(!nodes.isEmpty()){
                List<Object> childNodes = new List<Object>();
                for(Object node : nodes){
                    Map<String,Object> nodeMap = (Map<String,Object>)node;
                    if(nodeMap.get('id') != 'root'){
                        childNodes.add(node);
                    }
                }
                responseMap.put('nodes',childNodes);
            }
        }
        return responseMap;
    }
    
    public static Object createTask(String file_id,String content){
        Api_Info__mdt endpointPath = Api_Info__mdt.getInstance('createTask'); 
        Map<String,Object> requestValues = new Map<String,Object>();
        requestValues.put('file_id',file_id);
        requestValues.put('parent_id','root');
        requestValues.put('index',0); 
        requestValues.put('content',content);
        requestValues.put('note','');
        requestValues.put('checked',false);
        Map<String,Object> externalRequestBody = ApiRequestUtility.generateRequest('createTask',requestValues);
        HttpRequest request = CalloutService.prepareRequest(
            'callout:Dynalist'+endpointPath.MasterLabel,
            endpointPath.contentType__c,
            JSON.serialize(externalRequestBody)
        );

        HTTPResponse response =  CalloutService.doCallout(request);
        return (Map<String,Object>)JSON.deserializeUntyped(response.getBody());
    }
	
    public static Object updateTaskStatus(String file_id,String node_id,Boolean checked){
        Api_Info__mdt endpointPath = Api_Info__mdt.getInstance('updateTaskStatus'); 
        Map<String,Object> requestValues = new Map<String,Object>();
        requestValues.put('file_id',file_id); 
        requestValues.put('checked',checked);
        requestValues.put('node_id',node_id);
        
        Map<String,Object> externalRequestBody = ApiRequestUtility.generateRequest('updateTaskStatus',requestValues);
        HttpRequest request = CalloutService.prepareRequest(
            'callout:Dynalist'+endpointPath.MasterLabel,
            endpointPath.contentType__c,
            JSON.serialize(externalRequestBody)
        );

        HTTPResponse response =  CalloutService.doCallout(request);
        return (Map<String,Object>)JSON.deserializeUntyped(response.getBody());
    }
    
    public static Object updateTaskTitleAndNote(String file_id,String node_id,String content,String note){
        Api_Info__mdt endpointPath = Api_Info__mdt.getInstance('updateTaskTitleAndNote'); 
        Map<String,Object> requestValues = new Map<String,Object>();
        requestValues.put('file_id',file_id); 
        requestValues.put('content',content);
        requestValues.put('note',note);
        requestValues.put('node_id',node_id);
        
        Map<String,Object> externalRequestBody = ApiRequestUtility.generateRequest('updateTaskTitleAndNote',requestValues);
        HttpRequest request = CalloutService.prepareRequest(
            'callout:Dynalist'+endpointPath.MasterLabel,
            endpointPath.contentType__c,
            JSON.serialize(externalRequestBody)
        );

        HTTPResponse response =  CalloutService.doCallout(request);
        return (Map<String,Object>)JSON.deserializeUntyped(response.getBody());
    }
    
    public static Object deleteTask(String file_id,String node_id){
        Api_Info__mdt endpointPath = Api_Info__mdt.getInstance('deleteTask'); 
        Map<String,Object> requestValues = new Map<String,Object>();
        requestValues.put('file_id',file_id); 
        requestValues.put('node_id',node_id);
        Map<String,Object> externalRequestBody = ApiRequestUtility.generateRequest('deleteTask',requestValues);
        HttpRequest request = CalloutService.prepareRequest(
            'callout:Dynalist'+endpointPath.MasterLabel,
            endpointPath.contentType__c,
            JSON.serialize(externalRequestBody)
        );
        HTTPResponse response =  CalloutService.doCallout(request);
        return (Map<String,Object>)JSON.deserializeUntyped(response.getBody());
    }
}