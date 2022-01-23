<script>
    import { onMount } from "svelte";
    import {getUserTasks , updateTaskStatus , deleteTask , createTask , updateTaskTitleAndNote} from '../api';
    import { AUTH , signoutUser} from "../firebase";
    import Input from "../utility/Input.svelte";
    import {registerListener , EVENTS, fireEvent} from '../EventManager';
    import Button from "../utility/Button.svelte";
    import Popup from "../utility/Popup.svelte";
    import Task from "../Task.svelte";
    let store = [];

    let new_task_name;
    let selected_task;

    const handleChange = (e) => {
        new_task_name = e.target.value;
    }

    const handleTaskNameChange = (e) => {
        selected_task.content = e.target.value;
    }

    onMount( () => {

        registerListener(EVENTS.UPDATE_STATUS,processUpdateStatus);
        registerListener(EVENTS.DELETE_TASK,processDeleteTask);
        registerListener(EVENTS.OPEN_TASK_DETAIL,processOpenTaskDetail);
        registerListener(EVENTS.CLOSE_POPUP,processCloseTaskDetail);


        fireEvent(EVENTS.SHOW_SPINNER,{});

        getUserTasks(AUTH.currentUser.uid)
        .then(res => {
            if(res && res.nodes && res.nodes.length){
                store = res.nodes;
                fireEvent(EVENTS.HIDE_SPINNER,{});
            }else{
                fireEvent(EVENTS.HIDE_SPINNER,{});
            }
        })
        .catch(err => {
            fireEvent(EVENTS.HIDE_SPINNER,{});
        })
    });

    const processDeleteTask = (data) => {
        deleteTask(AUTH.currentUser.uid,data.task_id);
        store = store.filter(task => task.id !== data.task_id);
    }

    const processUpdateStatus = (data) => {
        for(let i=0;i<store.length;i++){
            if(store[i].id === data.task_id){
                store[i].checked = data.task_status;
            }
        }
        updateTaskStatus(AUTH.currentUser.uid,data.task_id,data.task_status);
    }

    const handleCreateTask = (evt) => {
        if(evt.key === "Enter" && new_task_name){
            fireEvent(EVENTS.SHOW_SPINNER,{});
            createTask(AUTH.currentUser.uid,new_task_name)
            .then(res => {
                store.push({
                    id:res.new_node_ids[0],
                    checked:false,
                    content : new_task_name,
                });
                new_task_name = "";
                store = store;
                fireEvent(EVENTS.HIDE_SPINNER,{});
            })
            .catch(err => {
                fireEvent(EVENTS.HIDE_SPINNER,{});
            });
        }
    }

    const processOpenTaskDetail = (task_id) => {
        selected_task = store.filter(task => task.id === task_id)[0];
        console.log(selected_task);
    }

    const processCloseTaskDetail = () => {
        selected_task = null;
    }

    const saveTaskTitleAndNote = () => {
        fireEvent(EVENTS.SHOW_SPINNER,{});
        updateTaskTitleAndNote(AUTH.currentUser.uid,selected_task.id,selected_task.content,selected_task.note)
        .then(res => {
            fireEvent(EVENTS.HIDE_SPINNER,{});
            for(let i=0;i<store.length;i++){
                if(store[i].id === selected_task.id){
                    store[i].note = selected_task.note;
                    store[i].content = selected_task.content;
                }
            }
        })
        .catch(err => {
            fireEvent(EVENTS.HIDE_SPINNER,{});
        });
    }

</script>

<div class="app-container">
    <header>
            <div class="input-container">
                <Input width_class="width-half" name="search" type="text" placeholder="Type your task here. Press enter to create" onChange={handleChange} onKeyUp={handleCreateTask} value={new_task_name}/>
            </div>
            <div class="action-container">
                <Button onClick={signoutUser} label="Sign out" type="secondary"/>
            </div>
    </header>
    {#if store && store.length}
        <div class="task-container">
            {#each store as task}
                <Task task_name={task.content} task_id={task.id} task_status={task.checked} />    
            {/each}
        </div>
    {/if}
</div>

{#if selected_task}
    <Popup header={selected_task.content} data={selected_task}>
        <br/>
        <br/>
        <div>
            <label for="task-name">Name</label>
        </div>
        <Input width_class="width-full" name="task-name" type="text" onChange={handleTaskNameChange} value={selected_task.content}/>
        <br/>
        <br/>
        <label for="task-note">Additional Notes</label>
        <textarea name="task-note" class="task-note" rows="10" bind:value={selected_task.note}></textarea>
        <Button onClick={saveTaskTitleAndNote} label="Save" type="secondary"/>
    </Popup>
{/if}

<style>
    .app-container{
        display: flex;
        align-items: center;
        flex-direction: column;
        margin:0;
        padding: 0;
        height: 100vh;
        background-color: var(--primary-color);
    }

    .input-container{
        width: 90%;
        display: flex;
        justify-content: center;
    }

    .action-container{
        width: 10%;
    }

    .task-container{
        display: flex;
        width: 100vw;
        justify-content: flex-start;
        align-items: center;
        flex-grow: 1;
        flex-direction: column;
    }

    header{
        width: 100vw;
        align-items: center;
        justify-content: center;
        display: flex;
        padding: 1em 0;
    }

    .task-note{
        width: 100%;
        background-color: var(--primary-color);
        border :  1px solid gray;
        color: white;
        box-sizing: border-box;
    }

    label {
        color: white;
        font-family: normal;
        padding: 1px 3px;
        background-color: var(--secondary-color);
        margin: 2em 0;
    }


</style>