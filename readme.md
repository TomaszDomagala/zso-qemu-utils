# Setup
default machine accounts:
root:root
zso:zso

Change /etc/ssh/sshd_config to:
PermitRootLogin yes
PasswordAuthentication yes

Then you can use ssh to login to the qemu machine.
Copy your ssh keys to the qemu machine as root@localost port 2222.

Setup ssh keys: `ssh-copy-id  -p 2222 root@localhost`
Copy your own ssh keys to the machine to use git and ssh: `scp -P 2222 -r ~/.ssh root@localhost:/root/` 
