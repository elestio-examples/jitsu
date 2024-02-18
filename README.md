# Jitsu CI/CD pipeline

<a href="https://dash.elest.io/deploy?source=cicd&social=dockerCompose&url=https://github.com/elestio-examples/jitsu"><img src="deploy-on-elestio.png" alt="Deploy on Elest.io" width="180px" /></a>

Deploy Jitsu server with CI/CD on Elestio

<img src="jitsu.png" style='width: 100%;'/>
<br/>
<br/>

# First Use

Jitsu self-hosted authorization is based on GitHub OAuth.

You'll need to create a GitHub OAuth application to get those values:

- Go to Github Developer settings » OAuth Apps » New OAuth App.
- Put any value to Application name
- Set Homepage URL and Authorization callback URL with value of [CI_CD_DOMAIN]
- Press Register application button
- Press Generate a new client secret button
- Update the env vars to indicate your credentials

      Open Elestio dashboard > Service overview > click on UPDATE CONFIG button > Env tab

- Copy Client ID and Client Secret values to GITHUB_CLIENT_ID and GITHUB_CLIENT_SECRET variables respectively.
- Click on Update & Restart

# Once deployed ...

You can open Jitsu UI here:

    URL: https://[CI_CD_DOMAIN]
    email: [ADMIN_EMAIL]
    password: [ADMIN_PASSWORD]

You can open PgAdmin web UI here:

    URL: https://[CI_CD_DOMAIN]:25538
    email: [ADMIN_EMAIL]
    password: [ADMIN_PASSWORD]

# Connectors

If you want to use Jitsu connectors, you will need a Kubernetes cluster.

## Kubernetes

If you don't have aready a Kubernetes cluster, you can deploy a new one on Elestio.

To do that, deploy a new instance Microk8s by clicking on this link: https://elest.io/open-source/microk8s.

Once deploy, you can connect over VS Code to generate a new kubeconfig file with this command in the terminal:

    microk8s config > kubeconfig

After the generation of the kubeconfig file, kindly proceed to edit the file by replacing the server IP value with your Global Private IP. For instance, following the generation, the configuration may resemble the following:

    server: https://10.68.72.19:16443

Subsequently, substitute the `10.68.72.19` placeholder with your specific Global Private IP, as identified in the overview tab.

Upon completion of the aforementioned steps, please proceed to download the modified kubeconfig file. Subsequently, paste the downloaded file into the VS Code window of your Jitsu instance (`/opt/app/`).

## syncctl

To use syncctl, you'll have to copy your `kubeconfig` file from your kubernetes instance and paste it in the root of your Jitsu project.
Then, uncomment in the docker-compose.yml file

    SYNCCTL_KUBERNETES_CLIENT_CONFIG: "/kubeconfig"
    - ./kubeconfig:/kubeconfig

Furthermore, ensure that you set the SYNCS_ENABLED parameter to `true` within your environment (ENV) file.

then, run the following command:

    docker-compose down
    docker-compose up -d
