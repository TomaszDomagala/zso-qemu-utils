# Setup


- `make backing-image.qcow2` - downloads the backing image and extracts it
- `qemu-img resize backing-image.qcow2 +10G` - increases the size of the backing image
- `make run-backing-image` - runs the backing image for initial setup
- login with root:root
- `lsblk` - confirm the backing image size
- `fdisk /dev/sda`
- `d 3` - delete the 3rd partition
- `n 3` - create a new partition, use default options
- `w` - write changes
- `reboot` - reboot the machine, reload the partition table
- `resize2fs /dev/sda3` - resize the partition
- Change /etc/ssh/sshd_config to: PermitRootLogin yes, PasswordAuthentication yes
- Setup ssh keys, from host: `ssh-copy-id  -p 2222 zso@localhost`
- Copy your own ssh keys to the machine to use git and ssh: `scp -P 2222 -r ~/.ssh zso@localhost:~`
- close the virtual machine
- `make current-image.qcow2` - creates the current image, backed by the backing image
- `make run-current-image` - runs the current image

You can add aliases to ssh config to simplify commands. In ~/.ssh/config:
```
Host zso-zso
  HostName localhost
  Port 2222
  User zso

Host root-zso
  HostName localhost
  Port 2222
  User root
```

Sources:
https://sandilands.info/sgordon/increasing-kvm-virtual-machine-disk-using-lvm-ext4
