<script>
    import { signinUser } from "../firebase";
    import {fireEvent,EVENTS} from "../EventManager";
    import Button from "../utility/Button.svelte";
    import Input from "../utility/Input.svelte";

    let user = {
        email:"",
        name:""
    }

    let showLogin = false;

    const showLoginPage = () => {
        showLogin = true;
    }

    const hideLoginPage = () => {
        showLogin = false;
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
    }

    .app-header{
        padding: 1.5em 1em;
    }

    .app-name {
        font-family: normal;
        font-size: 1.75em;
    }

    .logo {
        width: 3.8em;
        margin: 0 5px;
    }

    .form-container{
        height: 100vh;
    }

    .tagline{
        font-size: 2.5rem;
        margin: 0;
    }

    .form {
        padding: 3rem;
        width: 25%;
    }

    .highlight{
        color: var(--dark-color);
    }

    .home{
        width: 50%;
        height: 50%;
    }

    .form{
        width: 100%;
        height: 100%;
    }

    .sub-container{
        box-shadow: rgb(0 0 0 / 70%) 0 25px 50px -15px !important;
        width: 70%;
    }

</style>

<div class="flex flex-column container bg-secondary">
    
    {#if showLogin}
        <div class="form-container flex justify-center flex-row align-center login-form">
            <div class="sub-container flex justify-center flex-row bg-white">
                <div class="form bg-dark flex justify-center bg-white">
                    <img class="form" src="./login-form.svg" alt="oneList"/>
                </div>
                <!-- <div class="line"></div> -->
                <div class="form form-right flex justify-center flex-column bg-white">
                    <span class="app-name flex align-center justify-center text-bold text-primary">
                        onelist
                    </span>
                    <br/>
                    <Input name="email" type="email" label="Email" hasLabel onChange={handleChange}/>
                    <br/>
                    <Input name="password" type="password" label="Password" hasLabel onChange={handleChange}/>
                    <br/>
                    <Button onClick={onSignIn} label="Login" type="primary"/>
                    <br/>
                    <br/>
                    <Button onClick={hideLoginPage} label="Return to home" type="link"/>
                </div>
            </div>
        </div>
        {:else}
        <header class="app-header flex justify-space-between align-center bg-secondary">
            <span class="app-name flex align-center text-bold text-primary">
                <img class="logo" src="./logo.svg" alt="oneList"/>
            </span>
            <Button onClick={showLoginPage} label="Login" type="link"/>
            
        </header>
        
        <div class="flex justify-center flex-row align-center grow">
            <div class="flex justify-center flex-column align-center tagline-container">
                <h1 class="tagline">Manage your task better with </h1>
                <h1 class="tagline highlight text-underline">onelist</h1>
            </div>
            <div class="flex justify-center flex-column align-center tagline-container">
                <img class="home" src="./login.svg" alt="oneList"/>    
            </div>
        </div>

        <footer class="app-header flex justify-end align-center bg-secondary">
            <span class="dev-name text-bold highlight text-underline">Suban Khoja</span>
        </footer>
    {/if}
    
</div>