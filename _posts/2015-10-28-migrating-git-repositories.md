---
layout: post
title: "Migrating Git repositories"
date: 2015-10-28
categories: development
---

I recently needed to migrate our company's git repositories from GitHub to an on-prem BitBucket instance without 
completely blocking the on-going work of >100 engineers.  [While Atlassian provides a tool to import][bb-tool], I 
couldn't find the tool in our instance of BitBucket and had to resort to the built-in tools in git as described in the 
[GitHub documentation][gh-docs]:

0. [Make a bare mirrored clone of the repository][git-clone]

    ```sh
    git clone --mirror https://github.com/exampleuser/repository-to-mirror.git
    cd repository-to-mirror.git
    ```
    
0. [Set the push location on the mirror to your new remote][git-push]

    ```sh
    git remote set-url --push origin https://git.ourserver.com/exampleuser/mirrored.git
    git push --mirror
    ```

0. [Update from original repository in case changes are made][git-remote]

    ```sh
    git remote update
    ```

Once I had the commands down, it was just a matter of coordination and ordering.  My approach followed these basic steps:

0. Create users and groups in BitBucket (This was actually done for my since we had integrated our ActiveDirectory server 
with BitBucket).
0. Setup a Jenkins user with public SSH key so that our Jenkins jobs can clone repositories to build
0. Create a new, empty repo in BitBucket
0. Run through the steps above, using the new BitBucket repo
0. Clone Jenkins jobs, disable them (so they don't accidentally cause race conditions with the existing jobs) and update 
them to use the new BitBucket repo
0. Disable the old Jenkins jobs.
0. Enable the new Jenkins jobs and test them.
0. Restrict access to the old GitHub repository so that no one can write to it
0. Update the mirror from the old GitHub repository and push to BitBucket
0. Notify everyone to update their local repositories using `git remote set-url origin https://git.ourserver.com/exampleuser/mirrored.git`
0. Delete old Jenkins jobs
0. Set a reminder to delete the old repository in 2 sprints.

[bb-tool]: https://confluence.atlassian.com/bitbucket/import-code-from-an-existing-project-259358821.html#Importcodefromanexistingproject-Importfromahostingsiteorprojectusingtheimporter
[gh-docs]: https://help.github.com/articles/duplicating-a-repository/
[git-clone]: https://git-scm.com/docs/git-clone
[git-push]: https://git-scm.com/docs/git-push
[git-remote]: https://git-scm.com/docs/git-remote