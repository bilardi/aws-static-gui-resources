#!/usr/bin/env python3

import configuration
from aws_cdk import core
from aws_simple_pipeline.pipeline_stack import PipelineStack

project_name = configuration.project_name + '-pipeline'
github_owner = "bilardi"
github_repo = "aws-static-gui-resources"
github_branch = configuration.get_branch_name() # simple method to get the git branch name dinamically # "master"
github_token = core.SecretValue.secrets_manager(
    "/aws-simple-pipeline/secrets/github/token",
    json_field='github-token',
)
notify_emails = [ "your@email.net" ]
policies = [
    "AWSLambdaFullAccess",
    "AWSCloudFormationFullAccess",
    "AmazonS3FullAccess",
    "IAMFullAccess",
    "AmazonAPIGatewayAdministrator",
    "CloudFrontFullAccess"
]

app = core.App()
stage = configuration.get_stage_name(['main', 'master']) # simple method to manage one pipeline per git branch with exception the main branch
if app.node.try_get_context("stage"):
    stage = app.node.try_get_context("stage")
if stage != '':
    project_name += '-' + stage
PipelineStack(app, 
    id=project_name,
    stage=stage,
    github_owner=github_owner,
    github_repo=github_repo,
    github_branch=github_branch,
    github_token=github_token,
    notify_emails=notify_emails,
    policies=policies
)

app.synth()
