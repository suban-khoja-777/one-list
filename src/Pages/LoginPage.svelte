<script>
    import { signinUser } from "../firebase";
    import {fireEvent,EVENTS} from "../EventManager";
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
    }

    .app-footer{
        padding: .5em;
        width: 100%;
        background-color: rgb(216, 222, 228);
        color : black;
    }

    .app-name {
        font-family: normal;
        font-size: 1.75em;
    }

    .logo {
        width: 8em;
        margin: 0 5px;
    }

    .form-container{
        height: 100vh;
    }

    .form {
        padding: 3rem;
        width: 25%;
    }

    .home{
        width: 75%;
        height: 50%;
    }

    .form{
        width: 100%;
        height: 100%;
    }

    .sub-container{
        width: 100%;
    }

    .left{
        width: 75%;
    }

    .right{
        width : 25%;
        background-color : rgb(216, 222, 228);
    }

</style>

<div class="flex flex-row container">

    <div class="left flex flex-column justify-center grow bg-white">
        <div class="flex justify-center flex-row align-center grow">
            <div class="flex justify-center flex-column align-center tagline-container">
                <img class="home" src="./home.png" alt="onelist"/>    
            </div>
        </div>
    </div>

    <div class="right">
        <div class="form-container flex justify-center flex-column align-center login-form">
            <div class="sub-container flex justify-center grow">
                <!-- <div class="line"></div> -->
                <div class="form border-box form-right flex justify-center flex-column">
                    <span class="app-name flex align-center justify-center text-bold text-primary">
                        <img class="logo" src="./logo.svg" alt="oneList"/>
                    </span>
                    <br/>
                    <Input name="email" type="email" label="Email" hasLabel onChange={handleChange}/>
                    <br/>
                    <Input name="password" type="password" label="Password" hasLabel onChange={handleChange}/>
                    <br/>
                    <Button onClick={onSignIn} label="Login" type="primary"/>
                </div>
            </div>
            <footer class="app-footer border-box flex justify-center align-center">
                <span class="dev-name">Made with ❤️ by <span class="text-bold text-underline">Suban Khoja.</span></span>
            </footer>
        </div>
        
    </div>
    
</div>
