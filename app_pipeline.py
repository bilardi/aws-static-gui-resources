#!/usr/bin/env python3

from aws_cdk import core
from aws_simple_pipeline.pipeline_stack import PipelineStack

project_name = "aws-static-gui-resources"
github_owner = "bilardi"
github_repo = "aws-static-gui-resources"
github_branch = "master"
github_token = core.SecretValue.secrets_manager(
    "/aws-static-gui-resources/secrets/github/token",
    json_field='github-token',
)
notify_emails = [ "your@email.net" ]
policies = [
    "AWSLambdaFullAccess",
    "AWSCloudFormationFullAccess",
    "AmazonS3FullAccess",
    "IAMFullAccess",
]

app = core.App()
PipelineStack(app, 
    id=project_name,
    github_owner=github_owner,
    github_repo=github_repo,
    github_branch=github_branch,
    github_token=github_token,
    notify_emails=notify_emails,
    policies=policies
)

app.synth()
