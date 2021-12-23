# Setup ssh to use github with different user accounts

## Repositories using different github accounts

* Work github account: fabio-rojas-tfs
* Personal github account: baldr9

src: https://stackoverflow.com/questions/13103083/how-do-i-push-to-github-under-a-different-username


```
Step 1: Add to ~/.ssh/config
Host baldr9-github
HostName github.com
Port 22
User git
IdentityFile ~/.ssh/github_baldr9_id_rsa

Step 2:
git remote set-url origin git@baldr9-github:baldr9/sandbox.git

Step 3: verify git commands work
git pull
git push

```

* Notice that this requires you to modify the remote url which is different from the one used to clone
* Original git clone url: `git@github.com:baldr9/sandbox.git`
* Modified url so you use the correct ssh identity: `git@baldr9-github:baldr9/sandbox.git`

