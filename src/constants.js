
export const APP_NAME = 'onelist';

const API = {
    BASE_ENDPOINT : 'https://onelist-001-developer-edition.ap27.force.com/services/apexrest/api/',
    ENDPOINTS : {
        "getUserTasks" : 'getUserTasks',
        "updateTaskStatus" : "updateTaskStatus",
        "createTask" : "createTask",
        "deleteTask" : "deleteTask",
        "updateTaskTitleAndNote" : "updateTaskTitleAndNote"
    }
};

Object.freeze(API);

export {
    API
};
