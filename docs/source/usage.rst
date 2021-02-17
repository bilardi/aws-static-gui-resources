Usage
=====

The AWS static GUI resources contains the scripts for deploying all you need for CI / CD management.

* this repo inherits all scripts of `aws_simple_pipeline <https://aws-simple-pipeline.readthedocs.io/en/latest/usage.html>`_
* it works with `aws_static_website <https://aws-static-website.readthedocs.io/en/latest/usage.html>`_
* and it takes advantage of `aws_saving <https://aws-saving.readthedocs.io/en/latest/usage.html>`_

Example
#######

You need to create the infrastructure of your `static website <https://github.com/bilardi/auth0-APIGateway-CustomAuthorizer>`_ and you want to use an Auth0 application by Google 

* you have to create an `Auth0 application <https://auth0.com/docs/connections/social/google>`_
* and then, you can use the domain created by Auth0 and clientId for logging in your static website

Changes
*******

The files that you have to update on your `static website <https://github.com/bilardi/auth0-APIGateway-CustomAuthorizer>`_ are two:

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

* on pipeline and website `resources by AWS CDK <>`_
* on application `resources by Serverless framework <>`_
