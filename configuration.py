import git

project_name = "aws-static-gui-resources"
tags = {
    "Saving": "Enabled",
    "Delete": "0 18 . . .",
}

def get_branch_name():
    """
    gets the branch name of the current git repo
        Returns:
            A string of the git branch name
    """
    repo = git.Repo(search_parent_directories=True)
    branch = repo.active_branch
    return branch.name

def get_stage_name(exception_branches=None):
    """
    gets the stage name of this environment
        Args:
            exception_branches (list): list of the main and possible branches
        Returns:
            A string of the stage name
    """
    stage = get_branch_name()
    if stage in exception_branches:
        stage = ''
    return stage

def add_tags(core, app):
    """
    adds tags of application with exception that without stage
        Args:
            core (object): module aws_cdk.core
            app (object): construct which represents an entire CDK app
    """
    stage = app.node.try_get_context("stage")
    if stage:
        for tag in tags:
            core.Tags.of(app).add(tag, tags[tag])
