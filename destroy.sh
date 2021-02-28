#!/usr/bin/env bash

# check if there is environment variable named STAGE
if [ -z ${STAGE} ]; then
    echo
    echo Environment variable STAGE not exists
    echo Usage: STAGE=development bash $0
    echo
    exit 1
fi

# load resources
echo Load resources started on `date`
rm -rf resources
git clone -b aws-static-gui-resources https://github.com/bilardi/auth0-APIGateway-CustomAuthorizer resources

# destroy objects
cdk destroy -a 'python app_pipeline.py'
cdk destroy -a 'python app_website.py' -c stage=staging-${STAGE} # it is created by aws_simple_pipeline
cdk destroy -a 'python app_website.py' -c stage=production-${STAGE} # it is created by aws_simple_pipeline
cd resources/serverless/
serverless remove --stage staging-${STAGE}
serverless remove --stage production-${STAGE}
cd -
rm -rf resources
aws s3 ls | grep staging-${STAGE} | awk '{print $3}' | while read bucket; do aws s3 rb s3://$bucket --force; done
aws s3 ls | grep production-${STAGE} | awk '{print $3}' | while read bucket; do aws s3 rb s3://$bucket --force; done

# it is dangerous to comment the follow line: please test without while loop before
#aws s3 ls | grep aws-static-gui-resources | awk '{print $3}' | while read bucket; do aws s3 rb s3://$bucket --force; done
