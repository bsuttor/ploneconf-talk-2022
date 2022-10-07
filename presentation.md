[comment]: # (This presentation was made with markdown-slides)
[comment]: # (This is a CommonMark compliant comment. It will not be included in the presentation.)
[comment]: # (Compile this presentation with the command below)
[comment]: # (mdslides presentation.md --include medias)

[comment]: # (Set the theme:)
[comment]: # (THEME = simple)
[comment]: # (CODE_THEME = base16/zenburn)
[comment]: # (The list of themes is at https://revealjs.com/themes/)
[comment]: # (The list of code themes is at https://highlightjs.org/)

[comment]: # "You can also use quotes instead of parenthesis"
[comment]: # "THEME = simple"

[comment]: # (Pass optional settings to reveal.js:)
[comment]: # (controls: true)
[comment]: # (keyboard: true)
[comment]: # (markdown: { smartypants: true })
[comment]: # (hash: false)
[comment]: # (respondToHashChanges: false)
[comment]: # (Other settings are documented at https://revealjs.com/config/)

<div style="position:relative; top: -6.5em; color: white; font-weight: bold;"> Benoît Suttor | iMio | October 13, 2022 </div>

<div> How we created, deployed and updated over 200 websites at iMio with no downtime </div>

[comment]: # (!!! data-background-image="medias/background-presentation-imio.png" data-background-size="contain")


## About

This presentation is avaiable on github: https://github.com/bsuttor/ploneconf-talk-2022

I use markdown-slides to generated it: https://gitlab.com/da_doomer/markdown-slides

[comment]: # (!!! data-background-image="medias/background-presentation-imio.png" data-background-size="contain")


## Table of contents  <!-- .element: style="color:white; position: relative; top: -2em;" -->

1. **Introduction**
2. Buildout and Docker
3. Environments
4. CI/CD - Jenkins
5. Demo

[comment]: # (!!! data-background-image="medias/background-presentation-imio.png" data-background-size="contain")


## Introduction

- Creation of 200 websites developped in Plone
- Need process to update it
- Start thinking as DevOps and SRE (Site Reliability Engineering)

<!--
As we created and managed a lot of websites developped in Plone, we have to easily updated of all of them.
So we begin to think as DevOps enterprise and we start to create process to updated it -->


[comment]: # (!!! data-background-image="medias/background-presentation-imio.png" data-background-size="contain")


### What we want to improve
- Avoid human errors
- Remove ssh access to all your dev
```bash
# rm -rf /
```

[comment]: # (!!! data-background-image="medias/background-presentation-imio.png" data-background-size="contain")


### What we do not want anymore

- Devs who made bugfix directly on production

<iframe width="560" height="315" src="https://www.youtube.com/embed/9w0XCa6mMUQ" title="YouTube video player" frameborder="0" allow="accelerometer;  ; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>


[comment]: # (!!! data-auto-animate data-background-image="medias/background-presentation-imio.png" data-background-size="contain")

### We want small and frequent releases <!-- .element: style="color:white; position: relative; top: -0.5em;" -->

- Fewer changes in the source code  <!-- .element: class="fragment" data-fragment-index="1" -->
- Changes are still fresh in mind <!-- .element: class="fragment" data-fragment-index="2" -->
- If there is a bug, it’s easiest to find it <!-- .element: class="fragment" data-fragment-index="3" -->

<iframe width="560" height="315" src="https://www.youtube.com/embed/0Ms0ebQ5cp8" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe> <!-- .element: class="fragment" data-fragment-index="3" -->

- help junior dev to make release <!-- .element: class="fragment" data-fragment-index="4" -->

[comment]: # (!!! data-auto-animate data-background-image="medias/background-presentation-imio.png" data-background-size="contain")

### We want to use same tools than dev used

- Easy for dev to used it  <!-- .element: class="fragment" data-fragment-index="1" -->
- Make the same with buildout than eggs <!-- .element: class="fragment" data-fragment-index="2" -->

-> We decided to use zest.releaser for releasing our buildouts <!-- .element: class="fragment" data-fragment-index="3" -->

[comment]: # (!!! data-auto-animate data-background-image="medias/background-presentation-imio.png" data-background-size="contain")

## Table of contents <!-- .element: style="color:white; position: relative; top: -2em;" -->

1. Introduction
2. **Buildout and Docker**
3. Environments
4. CI/CD - Jenkins
5. Demo

[comment]: # (!!! data-background-image="medias/background-presentation-imio.png" data-background-size="contain")


### How we transforms our buildout  <!-- .element: style="color:white; position: relative; top: -3em;" -->

- Add version.txt file
- Add CHANGES.rst file


And it's all, we can now make "fullrelease" of our buildout.

[comment]: # (!!! data-auto-animate data-background-image="medias/background-presentation-imio.png" data-background-size="contain")


### Other avantage <!-- .element: style="color:white;" -->

We have a clear changelog of what is done in a new release

```markdown
imio.smartweb.policy 1.0.7

    Adapt SolR config to use tika for file indexing
    [mpeeters]

    Move/adapt ban_physicalpath method into imio.smartweb.common
    [boulch, laulaz]

imio.smartweb.common 1.0.6

    Add ban_physicalpath method (taken from policy)
    [boulch, laulaz]

pas.plugins.imio 2.0

    Get userid and user login for user connected by JWT.
    [bsuttor]
```

[comment]: # (!!!  data-auto-animate data-background-image="medias/background-presentation-imio.png" data-background-size="contain")


## What we done

3 envs dev/staging/production

[comment]: # (!!!  data-auto-animate data-background-image="medias/background-presentation-imio.png" data-background-size="contain")


## Table of contents <!-- .element: style="color:white; position: relative; top: -2em;" -->

1. Introduction
2. Buildout and Docker
3. **Environments**
4. CI/CD - Jenkins
5. Demo

[comment]: # (!!! data-background-image="medias/background-presentation-imio.png" data-background-size="contain")


### Environments  <!-- .element: style="color:white; position: relative; top: -1em;" -->
#### Devs

Use to local dev, with buildout, pip, mr.developer ...

#### Staging

New docker image is createad and deploy to staging instances at every commit in buildout repository.

#### Production

Production instances are updated when a new tag is push

[comment]: # (!!! data-background-image="medias/background-presentation-imio.png" data-background-size="contain")


### Staging

When a new commit is push to your buildout repo
- New docker image is build
- Tested
- Automaticaly deploy

[comment]: # (!!! data-background-image="medias/background-presentation-imio.png" data-background-size="contain")


### Production

When a new tag is created, latest staging Docker image is copied to docker prod registry.

So a human action is required to deploy to production and staging is automatically updated.

[comment]: # (!!! data-background-image="medias/background-presentation-imio.png" data-background-size="contain")


## Table of contents <!-- .element: style="color:white; position: relative; top: -2em;" -->

1. Introduction
2. Buildout and Docker
3. Environments
4. **CI/CD - Jenkins**
5. Demo

[comment]: # (!!! data-background-image="medias/background-presentation-imio.png" data-background-size="contain")


## How we do that : Jenkins

We used Jenkins to scan all our buildout repo on our organization on Github

We build Jenkins pipeline for our CI/CD

[comment]: # (!!! data-background-image="medias/background-presentation-imio.png" data-background-size="contain")

### Jenkins pipeline <!-- .element: style="color:white;" -->

![picture of Jenkins pipeline](medias/jenkins-pipeline.png)

[comment]: # (!!! data-background-image="medias/background-presentation-imio.png" data-background-size="contain")


### Jenkinsfile <!-- .element: style="color:white; position: relative; top: -1em;" -->
```
stage('Build main') {
    agent any
    when {
        allOf {
            branch "main"
            not {
                changelog '.*\\[(ci)?\\-?\\s?skip\\-?\\s?(ci)?\\].*'
            }
            not {
                changelog '^Back to development:*'
            }
            not {
                changelog '^Preparing release *'
            }
        }
    }
    steps {
        sh "docker build --pull -t imio-plone:latest ."
    }
}
```

[comment]: # (!!! data-background-image="medias/background-presentation-imio.png" data-background-size="contain")


```
stage('Test') {
    agent any
    when {
        allOf{
            not {
                buildingTag()
            }
            not {
                changelog '.*\\[(ci)?\\-?\\s?skip\\-?\\s?(ci)?\\].*'
            }
            not {
                changelog '^Back to development:*'
            }
            not {
                changelog '^Preparing release *'
            }
        }
    }
    steps {
        sh "make test-image"
    }
}
```

[comment]: # (!!! data-background-image="medias/background-presentation-imio.png" data-background-size="contain")

### Test image
- With pytest and docker-compose
- Test if "Listening at: http://0.0.0.0:8080" is in logs
- Test with restapi if our "policy" is installed

[comment]: # (!!! data-background-image="medias/background-presentation-imio.png" data-background-size="contain")


```
stage('Deploy to staging') {
    agent any
    when {
        allOf {
            branch "main"
            expression {
                currentBuild.result == null || currentBuild.result == 'SUCCESS'
            }
            not {
                changelog '.*\\[(ci)?\\-?\\s?skip\\-?\\s?(ci)?\\].*'
            }
            not {
                changelog '^Back to development:*'
            }
            not {
                changelog '^Preparing release *'
            }
        }
    }
    steps {
        sh "curl to-start-rundeck-job-which-restart-staging-instances"
    }
}
```

[comment]: # (!!! data-background-image="medias/background-presentation-imio.png" data-background-size="contain")


```
stage('Deploy') {
    agent any
    when {
        buildingTag()
    }
    steps {
        moveImageToProdRegistry(env.TAG_NAME, pipelineParams.imageName)
        sh "curl to-start-rundeck-job-which-restart-production-instances"
        emailext to: "talk2022+jenkins@imio.be",
            recipientProviders: [developers(), requestor()],
            subject: "New release deployed: ${currentBuild.displayName}",
            body: "The pipeline ${env.JOB_NAME} ${env.BUILD_NUMBER} released ${env.fullDisplayName} <br />See <a href='https://github.com/IMIO/buildout.smartweb/blob/main/CHANGES.rst'>Changelog</a><"

    }
}

```

[comment]: # (!!! data-background-image="medias/background-presentation-imio.png" data-background-size="contain")

### Pipeline with a new tag <!-- .element: style="color:white;" -->

![picture of Jenkins pipeline](medias/jenkins-pipeline-deploy.png)

[comment]: # (!!! data-background-image="medias/background-presentation-imio.png" data-background-size="contain")

Next step

Migration to Kubernetes with a Helm chart

[comment]: # (!!! data-background-image="medias/background-presentation-imio.png" data-background-size="contain")


## Table of contents <!-- .element: style="color:white; position: relative; top: -2em;" -->

1. Introduction
2. Buildout and Docker
3. Environments
4. CI/CD - Jenkins
5. **Demo**

[comment]: # (!!! data-background-image="medias/background-presentation-imio.png" data-background-size="contain")


Demo

[comment]: # (!!! data-background-image="medias/background-presentation-imio.png" data-background-size="contain")


Question(s)


![Twitter](https://skillicons.dev/icons?i=twitter) <!-- .element: style="position: relative; top: 0.7em; padding-top: 1px; padding-right: 1em; padding-left: 1em;" --> [bensuttor](https://twitter.com/bensuttor)

![Github](https://skillicons.dev/icons?i=github) <!-- .element: style="position: relative; top: 0.7em; padding-right: 1em; padding-left: 1em;" --> [bsuttor](https://github.com/bsuttor)


[comment]: # (data-background-image="medias/background-presentation-imio.png" data-background-size="contain")
