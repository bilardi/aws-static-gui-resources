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

# install dependencies
echo Install dependencies started on `date`
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
/usr/bin/python3 get-pip.py --force-reinstall
npm install -g npm@latest
echo Install ReactJS
npm install -g react-scripts@0.9.5
echo Install Serverless Framework
npm install -g serverless@1.74.1
npm install -g serverless-webpack
cd resources/serverless
npm install
cd -
echo Install AWS CDK
npm install -g cdk-assets aws-cdk
pip3 install --upgrade -r requirements.txt
if [ $? -ne 0 ]; then
    echo "INSTALL dependencies for stage ${STAGE} FAILED"
    exit 1
fi

# build interface
echo Build interface started on `date`
cd resources/reactJS
npm install
npm run build
if [ $? -ne 0 ]; then
    echo "BUILD interface for stage ${STAGE} FAILED"
    exit 1
fi
