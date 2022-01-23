<script>
import {APP_NAME} from '../constants';

export let show;

</script>

{#if show}
    <div class="main-container">
        <div class="container">
            <img class="logo" src="./logo.svg" alt="oneList"/>
            <span> {APP_NAME} </span>
        </div>
    </div>
{/if}


<style>
    .logo {
        width: 1.8em;
        height: 1.8em;
        margin: 0 5px;
    }

    .main-container{
        display: flex;
        align-items: center;
        flex-direction: column;
        justify-content: center;
        margin:0;
        padding: 0;
        height: 100vh;
        background-color: var(--primary-color);
    }

    .container{
        display: flex;
        align-items: center;
        color: white;
    }

</style>