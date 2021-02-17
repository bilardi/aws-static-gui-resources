#!/usr/bin/env bash

# check if there is environment variable named STAGE
if [ -z ${STAGE} ]; then
    echo
    echo Environment variable STAGE not exists
    echo Usage: STAGE=development bash $0
    echo
    exit 1
fi

# local
if [ -d /Users ]; then
    if [ -z ${AWS_PROFILE} ]; then
        echo
        echo Environment variable AWS_PROFILE not exists
        echo Usage: export AWS_PROFILE=your-account
        echo
        exit 1
    fi
fi

# deploy stage
echo Deploy lambdas started on `date`

cd resources/serverless/
serverless deploy --stage ${STAGE}
if [ $? -ne 0 ]; then
    echo "DEPLOY stage ${STAGE} FAILED"
    exit 1
fi
cd -

cdk deploy '*' -c stage=${STAGE} --require-approval never 
if [ $? -ne 0 ]; then
    echo "DEPLOY stage ${STAGE} FAILED"
    exit 1
fi

echo Copy build in $STAGE
cd application/reactJS
if [[ ${STAGE} == *'production'* ]]; then
    aws s3 sync build/ s3://bucket.domain.name/;
else
    aws s3 sync build/ s3://$STAGE-bucket.domain.name/;
fi
cd -