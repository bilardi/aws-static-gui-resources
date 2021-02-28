import git

project_name = "aws-static-gui-resources"

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
