# udacity-project-2

# This was edited in cloud shell

[![Python application test with Github Actions](https://github.com/huy-js/udacity-project-2/actions/workflows/pythonapp.yml/badge.svg)](https://github.com/huy-js/udacity-project-2/actions/workflows/pythonapp.yml)

[![Build Status](https://dev.azure.com/huycntt/udacity-project-2/_apis/build/status/huy-js.udacity-project-2?branchName=main)](https://dev.azure.com/huycntt/udacity-project-2/_build/latest?definitionId=17&branchName=main)

* First of all set up SSH Keys in your azure cloud shell, add the `id_rsa.pub` key to your GitHub repo ( ssh keys)  and then clone the project there.

```sh
ssh-keygen -t rsa
cat ~/.ssh/id_rsa.pub
```

![alt text](https://github.com/huy-js/udacity-project-2/blob/main/images/clonecode.png)

checkout your new branch
```sh
git branch
```
 Create a virtual environment for your application.

```sh
python3 -m venv ~/.myrepo
source ~/.myrepo/bin/activate
```

* Run `make all` which will install, lint, and test code

```sh
make all
```

![alt text](https://github.com/huy-js/udacity-project-2/blob/main/images/make%20all.png)

* Next set up Github Actions in your repo doign this :

> just add an space on botton of file `.github/workflows/pythonapp.yml` and save it

```sh
ls -lasth .github/workflows/pythonapp.yml
vim .github/workflows/pythonapp.yml
```

## Second : CI/CD Pipeline with AZURE DEVOPS

* Go to Azure Devops page  and sign in it, create a new Project inside your organization ( if you don't have an organization create one first).

* In your new Project in Azure DevOps, go to Project Settings and create a new `Pipeline --> Service Connection` as is explained on the YouTube video link  below ( Service Connection must be of Type Azure Resource Manager)

> Note 1 : Name your Service Connection `huy-ng-prj-2`
> Note 2: Use a link of as this `https://dev.azure.com/<organization>/<project_name>/_apis/serviceendpoint/endpoints?api-version=5.0-preview.2`  to find your ServiceConnectionID ( take note of this number since you will needed in the yaml file to build the pipeline). Replace the values for the ones that you created for your organization and project name.
Note3: the ServiceConnection ID is the number before the name `huy-ng-prj-2` of the above link.

* Create the webapp deploying the code from the local workspace to Azure app Service ( using Plan B1)  with this command:

```sh
az webapp up -n <name of webapp> --location eastus --sku B1
```
![alt text](https://github.com/huy-js/udacity-project-2/blob/main/images/app_service.png)


* Important you need to create a self host agent pool to handle your pipeline
> Create your own Azure Virtual Machine with following step in Udacity CD part
> Config this Agent Pool in project settings

![alt text](https://github.com/huy-js/udacity-project-2/blob/main/images/agentpool.png)


* In  your new Project in Azure DevOps, go to Pipelines -->New Pipeline --> GitHub --> Select Your Repo --> select `an Existing YAML file`

> Choose the `main` branch and the file named `azure-pipelines.yml` as is showed on the figure below
> Update the `azure-pipelines.yml` with the name of your webapp and your Service connection point ( Check YouTube video for a detailed explanation)
> Modifications are at variables webAppName & environmentName too !!!

* Choose Run Pipeline and your Azure DevOps Pipeline is going to start to be deployed with all his stages ( in this case 2: Build & deploy)

![alt text](https://github.com/huy-js/udacity-project-2/blob/main/images/custom-yaml-file-with-your-information.png)

* Perform a cosmetic change to your app.py , so you can see your CI/CD pipelines in action on Azure DevOps ( CD) & GitHub Actions (CI)

> On file `app.py` change this line:

```sh
html = "<h3">Sklearn Prediction Home</h3>"
```

for this one:

```sh
html = "<h2>Sklearn Prediction Home APP - RestAPI</h2>"
```

and then perform a quick lint and push the changes to your repo:

```sh
make lint
git add .
git commit -m "app.py updated"
git push origin main
```

* Check that the webapp is running opening his URL, example:

```sh
https://huy-ng-prj-2.azurewebsites.net/
```
![alt text](https://github.com/huy-js/udacity-project-2/blob/main/images/change%20to%20rest%20api.png)

 Update the file `make_predict_azure_app.sh` with the webapp service end point

```sh
grep https make_predict_azure_app.sh
```

* When the Azure DevOPs pipeline is successfully deployed, then its time to make a prediction on our webapp ( running in Azure App Service):

```sh
./make_predict_azure_app.sh
```

Answer:

```sh
Port: 443
{"prediction":[20.35373177134412]}
```

> Note: Azure cloud Shell is not enough good to perform locust there, so use a VM or your own local machine ( windows, macos, linux) to run Locust
> Note: copy both files (`loadtesting.sh` & `locustfile.py`) and run the `loadtesting.sh` file and open the browser on `http://localhost:8089/` :

```sh
./loadtesting.sh
```

>from there you can see how the load testing is performing and how you app established on a # of RPS
> This is good to know how good is your webapp and your plan to manage the requests. So you can decide to scale up the plan service of your webapp for example.
-> Locust could generate a stats report.

![alt text](https://github.com/huy-js/udacity-project-2/blob/main/images/locust.png)

## CLEANING OUT

* delete the resource group of your webapp created.

> At portal enter to your webapp service , locate the resource group.
> Go to that resource group and delete it.
> Wait for the notification of deletion .
> can close of the Azure portal

## Future Enhancements

* Adding more test cases.
* Creating a UI for making predictions.
* Using Github Actions instead of Azure pipelines.
* Run the app on Kubernetes cluster

## YouTube Demo