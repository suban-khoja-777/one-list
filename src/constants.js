
export const APP_NAME = 'onelist';

const API = {
    BASE_ENDPOINT : 'https://onelist-001-developer-edition.ap27.force.com/services/apexrest/api/v2/',
    ENDPOINTS : {
        "getUserTasks" : 'getUserTasks',
        "updateTask" : "updateTask",
        "createTask" : "createTask",
        "deleteTask" : "deleteTask"
    }
};

const statuses = [
    "Not Started",
    "In Progress",
    "Completed",
];

const columns = [
    {
        label : "Name",
        key : "task_name",
        show_in_list : true,
        show_in_detail : true,
        allow_inline_edit : false,
        field_type : "text"
    },
    {
        label : "Start Date",
        key : "task_start_date",
        show_in_list : true,
        show_in_detail : false,
        allow_inline_edit : true,
        field_type : "date"
    },
    {
        label : "End Date",
        key : "task_end_date",
        show_in_list : true,
        show_in_detail : false,
        allow_inline_edit : true,
        field_type : "date"
    },
    {
        label : "Status",
        key : "task_status",
        show_in_list : true,
        show_in_detail : false,
        allow_inline_edit : true,
        field_type : "select"
    },
    {
        label : "Notes",
        key : "task_note",
        show_in_list : false,
        show_in_detail : true,
        allow_inline_edit : false,
        field_type : "text-long"
    }
];

const getStatusClass = (_status) => {
    if(!_status) return "";
    return _status.replace(' ','-');
}


Object.freeze(API);
Object.freeze(statuses);
Object.freeze(columns);

export {
    API,
    statuses,
    columns,
    getStatusClass
};