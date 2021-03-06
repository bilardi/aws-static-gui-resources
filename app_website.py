#!/usr/bin/env python3

import configuration
from aws_cdk import core
from aws_static_website.website_stack import WebsiteStack

project_name = configuration.project_name + '-website'
website_params = {
    "index_document": "index.html",
    "error_document": "index.html"
}

app = core.App()
if app.node.try_get_context("stage"):
    project_name += '-' + app.node.try_get_context("stage")
WebsiteStack(app, 
    id=project_name,
    bucket_name="bucket.domain.name",
    website_params=website_params
)
configuration.add_tags(core, app)
app.synth()
