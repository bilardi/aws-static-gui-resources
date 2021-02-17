Getting started
===============

The static website with auth0 is a nice `static website in ReactJS <https://github.com/bilardi/auth0-APIGateway-CustomAuthorizer>`_.
In this repository there is only the application for deploying the AWS resources of a static website with auth0.
AWS static website is implemented in **AWS CDK** with **Python**.

It uses the packages

* `aws_simple_pipeline <https://github.com/bilardi/aws-simple-pipeline>`_ for managing the Continuous Deployment
* `aws_static_website <https://github.com/bilardi/aws-static-website>`_ for deploying the Website resources
* `aws_saving <https://github.com/bilardi/aws-saving>`_ for saving on AWS costs

It is part of the `educational repositories <https://github.com/pandle/materials>`_ to learn how to write stardard code and common uses of the TDD, CI and CD.

Prerequisites
#############

You have to install the `AWS Cloud Development Kit <https://docs.aws.amazon.com/cdk/latest/guide/>`_ (AWS CDK) for deploying the AWS static website:

.. code-block:: bash

    npm install -g aws-cdk # for installing AWS CDK
    cdk --help # for printing its commands

And you need an AWS account, in this repository called **your-account**.

Installation
############

The package is not self-consistent. So you have to download the package by github and to install the requirements before to deploy on AWS:

.. code-block:: bash

    git clone https://github.com/bilardi/aws-static-gui-resources
    cd aws-static-gui-resources/
    pip3 install --upgrade -r requirements.txt
    export AWS_PROFILE=your-account
    cdk deploy -a 'python app_pipeline.py' -c stage=sample

Read the documentation on `readthedocs <https://aws-static-gui-resources.readthedocs.io/en/latest/>`_ for

* Usage
* Development

Change Log
##########

See `CHANGELOG.md <https://github.com/bilardi/aws-static-gui-resources/blob/master/CHANGELOG.md>`_ for details.

License
#######

This package is released under the MIT license.  See `LICENSE <https://github.com/bilardi/aws-static-gui-resources/blob/master/LICENSE>`_ for details.
