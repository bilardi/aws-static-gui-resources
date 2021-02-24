#!/usr/bin/env python3

from aws_cdk import core
from aws_static_website.website_stack import WebsiteStack

project_name = "aws-static-gui-resources"
website_params = {
    "index_document": "index.html",
    "error_document": "index.html"
}

app = core.App()
WebsiteStack(app, 
    id=project_name,
    bucket_name="bucket.domain.name",
    website_params=website_params
)

app.synth()
