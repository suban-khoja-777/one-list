const events = {};

const EVENTS = {
    SHOW_SPINNER : 'SHOW_SPINNER',
    HIDE_SPINNER : 'HIDE_SPINNER',
    UPDATE_STATUS : "UPDATE_STATUS",
    DELETE_TASK : "DELETE_TASK",
    OPEN_TASK_DETAIL : "OPEN_TASK_DETAIL"
}

Object.freeze(EVENTS);

const registerListener = (eventName, callback) => {  
    if (!events[eventName]) {
        events[eventName] = [];
    }
    const duplicate = events[eventName].find((listener) => {
        return listener.callback === callback;
    });
    if (!duplicate) {
        events[eventName].push({ callback});
    }
};
 
const fireEvent = (eventName, payload) => {
    if (events[eventName]) {
        const listeners = events[eventName];
        listeners.forEach((listener) => {       
            try {
                listener.callback.call(this,payload);
            } catch (error) {
                console.error('@eventName : ',eventName) &&
                console.error('@listener : ',listener) &&
                console.error('@payload : ',payload) &&
                console.error('@error : ',error)
            }
        });
    }
};

export {
    registerListener,
    fireEvent,
    EVENTS
};
 