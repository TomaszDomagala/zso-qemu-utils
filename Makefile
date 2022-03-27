all: help

ROOT_DIR = $(shell pwd)

backing-image.qcow2.xz:
	@echo "Downloading backing image..."
	@wget -O $@ https://students.mimuw.edu.pl/ZSO/PUBLIC-SO/zso2022.qcow2.xz

backing-image.qcow2: backing-image.qcow2.xz
	@echo "Extracting backing image..."
	xz -k -d $<

zso2022_cow.qcow2: backing-image.qcow2
zso2022_cow.qcow2: ## Create zso2022 image
	@echo "Creating cow image..."
	qemu-img create -f qcow2 -b $< $@ 5G

.PHONY: qemu
qemu: ## Run qemu
	@echo "Running qemu"
	qemu-system-x86_64 --enable-kvm -m 15G -device virtio-balloon -smp 8 -cpu qemu64,smap,smep -nographic -device virtio-scsi-pci,id=scsi0 -drive file=zso2022_cow.qcow2,if=none,id=drive0 -device scsi-hd,bus=scsi0.0,drive=drive0 -net nic,model=virtio -net user,hostfwd=tcp::2222-:22


.PHONY: help
help:
	@awk -F ':|##' '/^[^\t].+?:.*?##/ {printf "\033[36m%-25s\033[0m %s\n", $$1, $$NF}' $(MAKEFILE_LIST)