# Azure Bookstore

> Do not do demo this repository directly. Check instructions below on how to get your instance automatically.

Azure Bookstore is a web application that lists staff recommended books.

## How to get this running on your own instance?

Pre-requisites:
 - `az-cli`: `brew install azure-cli`
 - `jq`: `brew install jq`

We've written a script that creates a new repository and sets up a series of AppService environnments in Azure. After that you're all ready to go. To get started first of all you'll need to generate a token with `package:read` and `repo` scopes. Ensure you have the latest version of `az` client and then:

1. Clone this repository locally.
2. Set two environment variables:
   - `GITHUB_TOKEN` with the PAT created above.
   - `REPO_NAME` the name of the repository to be creted on `github.com/octodemo`.
3. Run `./scripts/new_demo.sh`. 
4. It will ask you to login to azure on a browser. Please login to **sales@github.com** as this is where we have a dedicated resource group for the environments.
5. Follow the rest of the instructions to set the secrets.

You should now find your own repo under `github.com/octodemo/REPO_NAME`. In order to get all the goodies from Advaced Security **ensure you enable all the security and scanning options under repository settings**.

## What can I demo as part of this repository?

### Workflows, Actions, CI/CD

Actions is a big part of code to cloud at GitHub. As part of this repo, we prepared two types of demos :
  1. A short form demo : this showcases a basic flow of build, test, and deploy a small change to azure.
  2. A long form demo : this demo is longer (1 hour) and used for calls which are exclusively on Actions. It showcases some key features of actions.

#### Short form demo

##### [Recording](https://drive.google.com/file/d/1YtPCOzj6iOwmLxVpErok5NPQxGrFOT8l/view?usp=sharing )

The easiest way to demo the CI/CD capabilities of GitHub Actions is to open a PR with a small change that will kick-off the `branch-build.yml` workflow. The flow would be as follows :
  1. Make a change in the code and open a PR
  3. Go to the Actions Tab to show the live execution of the workflow.
  4. Explain how to define a workflow by going through the file `.github/workflows/branch-build.yml`
  
#### Long form demo

##### [Recording part 1](https://drive.google.com/open?id=1XDAgr9nww5mPPUqGjUOS9iNDi3NWN-9J)
##### [Recording part 2](https://drive.google.com/open?id=1XyCslhqxk76-gvINVUIyKo4RNZ4Zg2AR)

In order to demo the star features of Actions, you would need approximately 1 hour and this demo is for this kind of call exclusively dedicated to Actions. It can be used for talks or webinars as well.

We wanted this demo to be reusable so we scripted it in order to create different branches that you can switch to during the demo. The Actions demo is driven by [this board](https://github.com/octodemo/bookstore/projects/2). Here are the steps to do before the demo :

```bash
git fetch origin automate_demo
git checkout automate_demo
./scripts/demo-actions/init.sh
```

If you run `git branch` you will see that it created several branches. When moving from step i to step i+1 do :

```bash
git checkout demo-step-i+1
git push origin demo-step-i+1
```
Description of the steps:

   * demo-step-1 : demo how to create a workflow and talk about open source actions, reusability and standardise actions within the company
   * demo-step-2 : matrix build
   * demo-step-3 : save artifacts like some logs from selenium. This way, developers can download them easily and it is by default shared (no need to send zips via e-mails)
   * demo-step-4 : GPR integration
   * demo-step-5 : Caching to avoid going back and forth to Maven central at every build.
