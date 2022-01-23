public with sharing class ApiRequestUtility {
    public static Map<String,Object> generateRequest(String apiName , Map<String,Object> requestValues){
        Database_Setting__mdt db = Database_Setting__mdt.getInstance('default');
        switch on apiName {
            
            when 'getUserTasks' {
                String file_id = String.valueOf(requestValues.get('file_id'));
                return new Map<String,Object>{
                    'token' => db.Token__c,
                    'file_id' => file_id
                };
            }
            
            when 'createTask' {
                String parent_id = String.valueOf(requestValues.get('parent_id'));
                Integer index = Integer.valueOf(requestValues.get('index')); // 0 for top ,  -1 for at bottom. default -1
                String content = String.valueOf(requestValues.get('content'));
                String note = String.valueOf(requestValues.get('note'));
                String file_id = String.valueOf(requestValues.get('file_id'));
                Boolean checked = Boolean.valueOf(requestValues.get('checked')); // default to false
                return new Map<String,Object>{
                    'token' => db.token__c,
                    'file_id' => file_id,
                    'changes' => new List<Map<String,Object>>{
                        new Map<String,Object>{
                            'action' => 'insert',
                            'parent_id' => parent_id,
                            'index' => index,
                            'content' => content,
                            'note' => note,
                            'checked' => checked
                        }
                    }
                };

            }
            
                when 'updateTaskTitleAndNote' {
                String file_id = String.valueOf(requestValues.get('file_id'));
                String node_id = String.valueOf(requestValues.get('node_id'));
                String content = String.valueOf(requestValues.get('content'));
                String note = String.valueOf(requestValues.get('note'));
                return new Map<String,Object>{
                    'token' => db.token__c,
                    'file_id' => file_id,
                    'changes' => new List<Map<String,Object>>{
                        new Map<String,Object>{
                            'action' => 'edit',
                            'node_id'=> node_id,
                            'content' => content,
                            'note' => note
                        }
                    }
                };
            }

            when 'updateTaskNote' {
                String file_id = String.valueOf(requestValues.get('file_id'));
                String node_id = String.valueOf(requestValues.get('node_id'));
                String note = String.valueOf(requestValues.get('note'));
                return new Map<String,Object>{
                    'token' => db.token__c,
                    'file_id' => file_id,
                    'changes' => new List<Map<String,Object>>{
                        new Map<String,Object>{
                            'action' => 'edit',
                            'node_id'=> node_id,
                            'note' => note
                        }
                    }
                };
            }

            when 'updateTaskStatus' {
                String file_id = String.valueOf(requestValues.get('file_id'));
                String node_id = String.valueOf(requestValues.get('node_id'));
                Boolean checked = Boolean.valueOf(requestValues.get('checked'));
                return new Map<String,Object>{
                    'token' => db.token__c,
                    'file_id' => file_id,
                    'changes' => new List<Map<String,Object>>{
                        new Map<String,Object>{
                            'action' => 'edit',
                            'node_id'=> node_id,
                            'checked' => checked
                        }
                    }
                };
            }

            when 'deleteTask' {
                String file_id = String.valueOf(requestValues.get('file_id'));
                String node_id = String.valueOf(requestValues.get('node_id'));
                return new Map<String,Object>{
                    'token' => db.token__c,
                    'file_id' => file_id,
                    'changes' => new List<Map<String,Object>>{
                        new Map<String,Object>{
                            'action' => 'delete',
                            'node_id'=> node_id
                        }
                    }
                };
            }

            when else {
                return null;
            }
        }
    }
}