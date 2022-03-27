# Setup

To download and create image `make zso2022_cow.qcow2`

To run machine `make run`

default machine accounts:
- root:root
- zso:zso

Change /etc/ssh/sshd_config to:
- PermitRootLogin yes
- PasswordAuthentication yes

Then you can use ssh to login to the qemu machine.
Copy your ssh keys to the qemu machine as root@localost port 2222.

Setup ssh keys: `ssh-copy-id  -p 2222 zso@localhost`

Copy your own ssh keys to the machine to use git and ssh: `scp -P 2222 -r ~/.ssh zso@localhost:/root/` 

Open terminal `ssh -p 2222 zso@localhost`
