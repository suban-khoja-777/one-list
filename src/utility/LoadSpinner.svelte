<script>
    export let show;
</script>

{#if show}
    <div class="main-container flex align-center flex-column justify-center bg-secondary">
        <div class="flex align-center text-primary">
            <img class="logo" src="./logo.svg" alt="oneList"/>
            <!-- <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" style="margin: auto; background: rgb(241, 242, 243 / 0%); display: block;" width="250px" height="250px" viewBox="0 0 100 100" preserveAspectRatio="xMidYMid">
                <g data-v-fde0c5aa="" id="cbef1d1b-3337-428e-9c81-03105152b4bd" stroke="none" fill="#108F64">
                    <path d="M0 16.024L15.976 32 32 15.976 16.024 0 0 16.024zm15.989 7.323l-7.336-7.336 14.694-.022-7.358 7.358z"></path>
                </g>
            </svg> -->

        </div>
    </div>
{/if}


<style>
    
    .logo {
        width: 8em;
        height: 8em;
    }

    .main-container{
        margin:0;
        padding: 0;
        height: 100vh;
    }

</style>