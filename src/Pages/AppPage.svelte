<script>
    import { onMount } from "svelte";
    import {getUserTasks , updateTask , deleteTask , createTask } from '../api';
    import { AUTH , signoutUser} from "../firebase";
    import Input from "../utility/Input.svelte";
    import {registerListener , EVENTS, fireEvent} from '../EventManager';
    import Button from "../utility/Button.svelte";
    import Task from "../Task.svelte";
    import { columns } from "../constants";
    let store = [];

    let new_task_name;
    let selected_task;

    const handleChange = (e) => {
        new_task_name = e.target.value;
    }

    const handleTaskChange = (e) => {
        selected_task[e.target.dataset.field] = e.target.value;
    }

    onMount( () => {

        registerListener(EVENTS.UPDATE_TASK,processUpdateTask);
        registerListener(EVENTS.DELETE_TASK,processDeleteTask);
        registerListener(EVENTS.OPEN_TASK_DETAIL,processOpenTaskDetail);
        registerListener(EVENTS.CLOSE_POPUP,processCloseTaskDetail);

        fireEvent(EVENTS.SHOW_SPINNER,{});

        getUserTasks(AUTH.currentUser.uid)
        .then(res => {
            if(res && res.nodes && res.nodes.length){
                store = res.nodes;
                for(let i=0;i<store.length;i++){
                    if(store[i].note){
                        const json = JSON.parse(store[i].note);
                        store[i]['task_start_date'] = json.task_start_date;
                        store[i]['task_end_date'] = json.task_end_date;
                        store[i]['task_note'] = json.task_note;
                        store[i]['task_status'] = json.task_status;
                        store[i]['task_name'] = store[i].content;
                        store[i]['task_id'] = store[i].id;
                        delete store[i].note;
                        delete store[i].checked;
                        delete store[i].content;
                        delete store[i].id;
                    }
                }
                fireEvent(EVENTS.HIDE_SPINNER,{});
            }else{
                fireEvent(EVENTS.HIDE_SPINNER,{});
            }
        })
        .catch(err => {
            fireEvent(EVENTS.HIDE_SPINNER,{});
        })
    });

    const processDeleteTask = () => {
        deleteTask(AUTH.currentUser.uid,selected_task.task_id);

        store = store.filter(task => task.task_id !== selected_task.task_id);
        processCloseTaskDetail();
    }

    const processUpdateTask = (data) => {
        const _note = {
            task_start_date : data.task_start_date ? data.task_start_date : "",
            task_end_date : data.task_end_date ? data.task_end_date : "",
            task_note : data.task_note ? data.task_note : "",
            task_status : data.task_status ? data.task_status : "",
        }
        updateTask(AUTH.currentUser.uid,data.task_id,data.task_name,JSON.stringify(_note));
    }

    const handleCreateTask = (evt) => {
        if(evt.key === "Enter" && new_task_name){
            fireEvent(EVENTS.SHOW_SPINNER,{});
            createTask(
                AUTH.currentUser.uid,
                new_task_name,
                JSON.stringify({
                    task_start_date : "",
                    task_end_date : "",
                    task_note : "",
                    task_status : "Not Started"
                })
            )
            .then(res => {
                store.push({
                    task_id:res.new_node_ids[0],
                    task_name : new_task_name,
                    task_start_date : "",
                    task_end_date : "",
                    task_note : "",
                    task_status : "Not Started"
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
        selected_task = store.filter(task => task.task_id === task_id)[0];

    }

    const processCloseTaskDetail = () => {
        selected_task = null;
    }

    const saveTaskTitleAndNote = () => {
        fireEvent(EVENTS.SHOW_SPINNER,{});
        const _note = {
            task_start_date : selected_task.task_start_date ? selected_task.task_start_date : "",
            task_end_date : selected_task.task_end_date ? selected_task.task_end_date : "",
            task_note : selected_task.task_note ? selected_task.task_note : "",
            task_status : selected_task.task_status ? selected_task.task_status : ""
        }
        updateTask(AUTH.currentUser.uid,selected_task.task_id,selected_task.task_name,JSON.stringify(_note))
        .then(res => {
            fireEvent(EVENTS.HIDE_SPINNER,{});
        })
        .catch(err => {
            fireEvent(EVENTS.HIDE_SPINNER,{});
        });
    }

</script>

<div class="app-container flex align-center flex-column">
    <header class="flex border-box align-center justify-center">
        <div class="logo-container text-center">
            <img class="logo" src="./logo.svg" alt="onelist"/>
        </div>
        
        <div class="input-container flex justify-center">
            <Input width_class="width-half" name="search" type="text" placeholder="Type your task here. Press enter to create" onChange={handleChange} onKeyUp={handleCreateTask} value={new_task_name}/>
        </div>

        <div class="action-container text-center">
            <Button onClick={signoutUser} label="Sign out" type="link"/>
        </div>

    </header>
    {#if store && store.length}
        <div class="task-container flex justify-start align-center grow flex-column">
            <li class="columns flex justify-space-between align-center text-white text-bold">
                {#each columns as column}
                    {#if column.show_in_list}
                        <span class="column flex justify-center grow border-box text-bold {column.key} { column.show_header ? 'bg-primary' : ''}">{ column.show_header ? column.label : ''}</span>    
                    {/if}
                {/each}
            </li>
            {#each store as task}
                <Task {task} />    
            {/each}
        </div>
    {/if}
</div>

{#if selected_task}
    <div class="bg-drop fixed outsider bg-transparent" on:click={processCloseTaskDetail}></div>
    <div class="fixed side-popup {selected_task ? 'side-popup-show' : ''}">
        <div class="modal bg-white absolute border-primary">
            <div class="modal-content relative">
                <div class="modal-header flex justify-space-between text-primary">
                    <span class="header text-bold text-primary">{selected_task.task_name}</span>
                    <Button onClick={processDeleteTask} label="Delete" type="link"/>
                </div>    
                {#each columns as column}
                    {#if column.show_in_detail}
                        <br/>
                        <Input width_class="width-full" hasLabel label={column.label} type={column.field_type} onChange={handleTaskChange} value={selected_task[column.key]} data_field={column.key}/>
                        <br/>  
                    {/if}
                {/each}
                <Button onClick={saveTaskTitleAndNote} label="Save" type="secondary"/>
                <Button onClick={processCloseTaskDetail} label="Close" type="primary"/>
            </div>
        </div>
    </div>
{/if}

<style>

    .logo {
        width: 8em;
    }

    .columns{
        width: 100%;
        list-style: none;
    }

    .column{
        padding: 0.5rem;
    }

    .task_name{
        width: 60%;
    }

    .task_start_date,.task_end_date{
        width: 15%;
    }

    .task_status{
        width: 10%;
    }

    .column:first-of-type{
        border-left: 0;
    }

    .column:last-of-type{
        border-right: 0;
    }

    .app-container{
        margin:0;
        padding: 0;
        height: 100vh;
    }

    .logo-container{
        width: 10%;
    }

    .input-container{
        width: 80%;
    }

    .action-container{
        width: 10%;
    }

    .task-container{
        width: 95vw;
    }

    header{
        width: 100vw;
        padding: 1em;
    }

    .task-note{
        width: 100%;
    }

    .side-popup{
        top: 0;
        width: 50%;
        left: 0%;
        bottom: 0;
        height: 100%;
        animation-duration: 1s;
        animation-name: slidein;
        z-index: 9
    }

    .outsider{
        top: 0;
        left: 0;
        bottom: 0;
        right : 0;
        z-index: 5;
    }

    @keyframes slidein {
        from {
            left: -50%;
        }

        to {
            left: 0%;
        }
    }

    .modal{
        width: 100%;
        height: 100%;
        padding : 1rem 3rem 1rem 2rem;
    }

    .header{
        font-size: 2rem;
    }

    

</style>