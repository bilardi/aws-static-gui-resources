Usage
=====

The AWS static GUI resources contains the scripts for deploying all you need for CI / CD management.

* this repo inherits all scripts of `aws_simple_pipeline <https://aws-simple-pipeline.readthedocs.io/en/latest/usage.html>`_
* it works with `aws_static_website <https://aws-static-website.readthedocs.io/en/latest/usage.html>`_
* and it takes advantage of `aws_saving <https://aws-saving.readthedocs.io/en/latest/usage.html>`_

The packages allow you to manage many environments in parallel by the parameter named **stage**:

* it can be a contextual string parameter as described in :ref:`Development section <Development>`
* or it can be a parameter of the package initialiazed as implemented in the **app_pipeline.py** where it is the branch name

Example
#######

You need to create the infrastructure of your `static website <https://github.com/bilardi/auth0-APIGateway-CustomAuthorizer>`_ and you want to use an Auth0 application by Google 

* you have to create an `Connect Apps to Google <https://auth0.com/docs/connections/social/google>`_
* and then, you can use the domain created by Auth0 and clientId for logging in your static website

Connect Apps to Google
**********************

When you have

* created your ID client OAuth 2.0 on `API credentials section <https://console.developers.google.com/apis/credentials>`_,
* and configured your `Auth0 connection <https://manage.auth0.com/#/connections/social>`_,

You can configure your `Auth0 application <https://manage.auth0.com/#/applications>`_ with the names of your buckets used on **Allowed Callback URLs**:

* for your local tests when you run your static website by ``run start`` (see its `README.md <https://github.com/bilardi/auth0-APIGateway-CustomAuthorizer/tree/master/reactJS>`_), http://localhost:3000/callback
* for your environment named **sample** that you run by app_pipeline.py ``-c stage=sample`` (see :ref:`Getting started <Getting started>`), you have to add the domain name of your buckets, in this example they are

  * http://staging-sample-bucket.domain.name.s3-website-eu-west-1.amazonaws.com/callback
  * http://production-sample-bucket.domain.name.s3-website-eu-west-1.amazonaws.com/callback

* for your production environment that you run without stage, in this example, the domain names are

  * http://staging-bucket.domain.name.s3-website-eu-west-1.amazonaws.com/callback
  * http://bucket.domain.name.s3-website-eu-west-1.amazonaws.com/callback

Changes
*******

The files that you have to update on your `static website <https://github.com/bilardi/auth0-APIGateway-CustomAuthorizer>`_ are three:

* **reactJS/src/Auth/Auth.js**, for managing more environment and so more callback URLs
* **reactJS/src/Auth/auth0-variables.js**, for changing the Auth0 details
* **serverless/serverless.yml**,

  * for reducing the service name that it has not to have more than 64 characters
  * for upgrading the nodejs version
  * for changing the Auth0 details

In `this commit <https://github.com/bilardi/auth0-APIGateway-CustomAuthorizer/commit/4831f724eb9f45957c8007cdafbe7943d43a9c2e>`_, you can find an example of a change.

Saving
******

It is simple to use **aws_saving**: you only have to add `some tags <https://aws-saving.readthedocs.io/en/latest/usage.html>`_ and deploy it!

In these commits, you can find an example of where to change:

* on pipeline and website `resources by AWS CDK <https://github.com/bilardi/aws-static-gui-resources/commit/15901d0c4d31e7d91c2bca50f4fdae619a594f0e>`_
* on application `resources by Serverless framework <https://github.com/bilardi/auth0-APIGateway-CustomAuthorizer/commit/23f03bb9a7d91e54155e11f3923ae035e1e2031b>`_
