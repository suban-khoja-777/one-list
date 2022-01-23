import { API } from "./constants";

export const getUserTasks = (user_id) => {
    return fetch(API.BASE_ENDPOINT+API.ENDPOINTS.getUserTasks,{
        method : 'POST',
        body : JSON.stringify({
            user_id
        })
    })
    .then(res => res.json())
    .catch(err => {
        console.error('getUserTasks : ',err);
    });
};

export const createTask = (user_id,task_name) => {
    return fetch(API.BASE_ENDPOINT+API.ENDPOINTS.createTask,{
        method : 'POST',
        body : JSON.stringify({
            user_id,
            content : task_name
        })
    }).then(res => res.json())
    .catch(err => {
        console.error('createTask : ',err);
    });
};

export const deleteTask = (user_id,node_id) => {
    return fetch(API.BASE_ENDPOINT+API.ENDPOINTS.deleteTask,{
        method : 'POST',
        body : JSON.stringify({
            user_id,
            node_id
        })
    }).then(res => res.json())
    .catch(err => {
        console.error('deleteTask : ',err);
    });
};

export const updateTaskStatus = (user_id,node_id,checked) => {
    return fetch(API.BASE_ENDPOINT+API.ENDPOINTS.updateTaskStatus,{
        method : 'POST',
        body : JSON.stringify({
            user_id,
            node_id,
            checked
        })
    }).then(res => res.json())
    .catch(err => {
        console.error('updateTaskStatus : ',err);
    });
};

export const updateTaskTitleAndNote = (user_id,node_id,content,note) => {
    return fetch(API.BASE_ENDPOINT+API.ENDPOINTS.updateTaskTitleAndNote,{
        method : 'POST',
        body : JSON.stringify({
            user_id,
            node_id,
            content,
            note
        })
    }).then(res => res.json())
    .catch(err => {
        console.error('updateTaskTitleAndNote : ',err);
    });
};
