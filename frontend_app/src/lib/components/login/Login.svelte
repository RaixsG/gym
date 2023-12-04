<script>
    import axios from "axios";
    import { goto } from "$app/navigation";
    import { appStatus } from "$stores";

    let user = null;
    let password = null;

    const url = "http://localhost:3000/api/login";

    const doLogin = () => {
        console.log(
            `Make API login request with following data: { user: ${user}, password: ${password} }`,
        );
        axios
            .post(url, {
                usuario: user,
                password: password,
            })
            .then((res) => {
                console.log(res.data);
                console.log("EXITO");
                localStorage.setItem("appStatus", "auth");
                appStatus.set("auth");
                localStorage.setItem("user", JSON.stringify(res.data.user));
                goto("/");
            })
            .catch((err) => {
                console.log(JSON.stringify(err));
                alert("Usuario o contraseña incorrectos");
            });
    };
</script>

<div class="login wrap">
    <div class="h1">Inicio de Sesión</div>
    <form on:submit={doLogin}>
        <input
            placeholder="User"
            type="text"
            name="user"
            on:change={(e) => (user = e.target.value)}
        />
        <input
            placeholder="Password"
            type="password"
            name="password"
            on:change={(e) => (password = e.target.value)}
        />
        <button class="btn" type="submit">Login</button>
    </form>
</div>

<style>
    .login {
        width: 340px;
        height: 400px;
        background-color: var(--toggle-color);
        padding: 47px;
        padding-bottom: 57px;
        color: var(--text-color);
        border-radius: 17px;
        padding-bottom: 50px;
        font-size: 1.3em;
        font-family: var(--font);
    }

    .login input[type="text"],
    .login input[type="password"] {
        opacity: 1;
        display: block;
        border: none;
        outline: none;
        width: 100%;
        padding: 13px 18px;
        margin: 20px 0 0 0;
        font-size: 0.8em;
        border-radius: 100px;
        background: var(--text-color);
        color: #fff;
    }

    .login input:focus {
        animation: bounce 1s;
        -webkit-appearance: none;
    }

    .login button[type="submit"],
    .h1 {
        border: 0;
        outline: 0;
        width: 100%;
        padding: 13px;
        margin: 40px 0 0 0;
        border-radius: 500px;
        font-weight: 600;
        animation: bounce2 1.6s;
    }

    .h1 {
        padding: 0;
        position: relative;
        top: -35px;
        display: block;
        margin-bottom: -0px;
        font-size: 1.3em;
        text-align: center;
    }

    .btn {
        background: linear-gradient(144deg, #af40ff, #5b42f3 50%, #00ddeb);
        color: #fff;
        padding: 16px !important;
    }

    .btn:hover {
        background: linear-gradient(144deg, #1e1e1e, 20%, #1e1e1e 50%, #1e1e1e);
        color: rgb(255, 255, 255);
        padding: 16px !important;
        cursor: pointer;
        transition: all 0.4s ease;
    }

    .login input[type="text"] {
        animation: bounce 1s;
        -webkit-appearance: none;
    }

    .login input[type="password"] {
        animation: bounce1 1.3s;
    }

    @media only screen and (max-width: 600px) {
        .login {
            width: 70%;
            padding: 3em;
        }
    }

    @keyframes bounce {
        0% {
            transform: translateY(-250px);
            opacity: 0;
        }
    }

    @keyframes bounce1 {
        0% {
            opacity: 0;
        }

        40% {
            transform: translateY(-100px);
            opacity: 0;
        }
    }

    @keyframes bounce2 {
        0% {
            opacity: 0;
        }

        70% {
            transform: translateY(-20px);
            opacity: 0;
        }
    }
</style>
