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
git clone https://github.com/bilardi/auth0-APIGateway-CustomAuthorizer resources

# install dependencies
echo Install dependencies started on `date`
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
/usr/bin/python3 get-pip.py --force-reinstall
npm install -g npm@latest
echo Install ReactJS
npm install -g react-scripts@0.9.5
echo Install Serverless Framework
npm install -g serverless@1.74.1
npm install serverless-python-requirements

# build interface
echo Build interface started on `date`
cd resources/application/reactJS
npm run build
if [ $? -ne 0 ]; then
    echo "BUILD interface for stage ${STAGE} FAILED"
    exit 1
fi
echo Create ReactJS / Cloudfront patch
cp build/index.html build/callback.html
cp build/index.html build/home.html
cp build/index.html build/profile.html
