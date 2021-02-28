Development
===========

This repo contains,

* **app.py** files of the **aws_simple_pipeline** and **aws_static_website** packages
* bash scripts for automation of **aws_simple_pipeline**

A possible improvement is to use AWS CDK system for replacing the Serverless Framework.
Then, the unit test and integration test scripts will work.

Run scripts
###########

For running all scripts, you need only your client: you can use a `virtual environment <https://simple-sample.readthedocs.io/en/latest/howtomake.html>`_ 

.. code-block:: bash

    cd aws-static-gui-resources/
    STAGE=my-development bash local.sh

This step is important for testing all process from building to deploying.

Deploy on AWS
#############

AWS CDK system allows you to create an **aws_simple_pipeline** for each environment by adding a contextual string parameter (in the sample is **stage**) !

This step is also useful when you need to update a policy for AWS Codebuild or other Pipeline configuration.

.. code-block:: bash

    cd aws-simple-pipeline/
    export AWS_PROFILE=your-account
    export STAGE=my-development
    cdk deploy -a 'python app_pipeline.py' -c stage=${STAGE}

or, if you want to use the branch name like the stage name, here is the example with branch named **my-development**

.. code-block:: bash

    cd aws-simple-pipeline/
    git checkout -b my-development
    export AWS_PROFILE=your-account
    cdk deploy -a 'python app_pipeline.py'

Remove on AWS
#############

If you use the saving tags, you can forget to destroy all resources because they will be deleted at time that you will have specified by `saving lambda <https://aws-saving.readthedocs.io/en/latest/>`_ that you will have deployed.

Alternatively, you can destroy the resources with a few commands

.. code-block:: bash

    cd aws-static-gui-resources/
    export AWS_PROFILE=your-account
    export STAGE=my-development
    cdk destroy -a 'python app_pipeline.py' -c stage=${STAGE} 
    cdk destroy -a 'python app_website.py' -c stage=staging-${STAGE} # it is created by aws_simple_pipeline
    cdk destroy -a 'python app_website.py' -c stage=production-${STAGE} # it is created by aws_simple_pipeline

or, if you want to use the branch name like the stage name, here is the example with branch named **my-development**

.. code-block:: bash

    cd aws-static-gui-resources/
    git checkout my-development
    export AWS_PROFILE=your-account
    export STAGE=my-development
    cdk destroy -a 'python app_pipeline.py'
    cdk destroy -a 'python app_website.py' -c stage=staging-${STAGE} # it is created by aws_simple_pipeline
    cdk destroy -a 'python app_website.py' -c stage=production-${STAGE} # it is created by aws_simple_pipeline

The methods above, they are missing to destroy some objects, so alternatively you can use these commands

.. code-block:: bash

    cd aws-static-gui-resources/
    git checkout my-development
    export AWS_PROFILE=your-account
    export STAGE=my-development
    STAGE=${STAGE} bash destroy.sh
