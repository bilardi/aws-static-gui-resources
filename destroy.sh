#!/usr/bin/env bash

# check if there is environment variable named STAGE
if [ -z ${STAGE} ]; then
    echo
    echo Environment variable STAGE not exists
    echo Usage: STAGE=development bash $0
    echo
    exit 1
fi

# for deleting the production environments
if [ ${STAGE} == 'force' ]; then
    STAGE=""
else
    STAGE="-${STAGE}"
fi

# load resources
if [ ! -d resources ]; then
    echo Load resources started on `date`
    git clone -b aws-static-gui-resources https://github.com/bilardi/auth0-APIGateway-CustomAuthorizer resources
fi

# destroy resources
echo Destroy resources started on `date`
cdk destroy -a 'python app_pipeline.py'
cdk destroy -a 'python app_website.py' -c stage=staging${STAGE} # it is created by aws_simple_pipeline
if [ -z ${STAGE} ]; then
    cdk destroy -a 'python app_website.py' # it is created by aws_simple_pipeline
else
    cdk destroy -a 'python app_website.py' -c stage=production${STAGE} # it is created by aws_simple_pipeline
fi
cd resources/serverless/
serverless remove --stage staging${STAGE}
serverless remove --stage production${STAGE}
cd -
rm -rf resources

# it is dangerous to comment the follow line: please test without while loop before
#aws s3 ls | grep staging${STAGE} | awk '{print $3}' | while read bucket; do aws s3 rb s3://$bucket --force; done
#aws s3 ls | grep production${STAGE} | awk '{print $3}' | while read bucket; do aws s3 rb s3://$bucket --force; done
#aws s3 ls | grep aws-static-gui-resources | awk '{print $3}' | while read bucket; do aws s3 rb s3://$bucket --force; done
