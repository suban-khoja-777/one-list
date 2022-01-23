<script>
    import { signinUser } from "../firebase";
    import {fireEvent,EVENTS} from "../EventManager";
    import {APP_NAME } from '../constants';
    import Button from "../utility/Button.svelte";
    import Input from "../utility/Input.svelte";

    let user = {
        email:"",
        name:""
    }

    const handleChange = (e) => {
        user[e.target.name] = e.target.value;
    }

    const onSignIn = () => {
        
        const email = user.email;
        const password = user.password;

        if(email && password){
            fireEvent(EVENTS.SHOW_SPINNER,{});
            signinUser(email,password)
            .then (res => {
                fireEvent(EVENTS.HIDE_SPINNER,{});
            })
            .catch(err => {
                fireEvent(EVENTS.HIDE_SPINNER,{});
            });
        }
    }

</script>

<style>

    .container{
        margin: 0;
        padding: 0;
        height: 100vh;
        background-color: var(--primary-color);
    }

    .app-header{
        background-color: var(--primary-color);
        padding: 0.5em;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .app-name {
        color: white;
        font-family: normal;
        display: flex;
        align-items: center;
        font-weight: 600;
        font-size: 1em;
    }

    .logo {
        width: 1.8em;
        height: 1.8em;
        margin: 0 5px;
    }

    .form-container{
        display: flex;
        justify-content: center;
        flex-direction: column;
        align-items: center;
        padding: 1em 0em;
        width: 100vw;
        height: 75vh;
    }

    .form {
        display: flex;
        justify-content: center;
        flex-direction: column;
        box-shadow: var(--secondary-color) 0 25px 50px -15px !important;
        padding: 1em;
        width: 25vw;
    }

    .dev-name{
        box-shadow: white 0 25px 50px -15px !important;
        padding: 1em;
        color: white;
        border-radius: 50px;
    }
</style>

<div class="container">
    
    <header class="app-header">
        <span class="app-name">
            <img class="logo" src="./logo.svg" alt="oneList"/>
            {APP_NAME}
        </span>
        <span class="dev-name">Suban Khoja</span>
    </header>
    
    <div class="form-container login-form">
        <div class="form">
            <Input name="email" type="email" label="Email" hasLabel onChange={handleChange}/>
            <Input name="password" type="password" label="Password" hasLabel onChange={handleChange}/>
            <br/>
            <Button onClick={onSignIn} label="Login" type="secondary"/>
        </div>
    </div>
       
</div>