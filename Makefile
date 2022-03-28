all: help

ROOT_DIR = $(shell pwd)

backing-image.qcow2.xz:
	@echo "Downloading backing image..."
	@wget -O $@ https://students.mimuw.edu.pl/ZSO/PUBLIC-SO/zso2022.qcow2.xz

backing-image.qcow2: backing-image.qcow2.xz
	@echo "Extracting backing image..."
	xz -k -d $<

current-image.qcow2: backing-image.qcow2
current-image.qcow2: ## Create zso2022 image
	@echo "Creating cow image..."
	qemu-img create -f qcow2 -b $< $@ 15G

# .PHONY: qemu
# run: ## Run qemu
# 	@echo "Running qemu"
# 	qemu-system-x86_64 --enable-kvm -m 15G -device virtio-balloon -smp 8 -cpu qemu64,smap,smep -nographic -device virtio-scsi-pci,id=scsi0 -drive file=current-image.qcow2,if=none,id=drive0 -device scsi-hd,bus=scsi0.0,drive=drive0 -net nic,model=virtio -net user,hostfwd=tcp::2222-:22



.PHONY: run-backing-image
run-backing-image: backing-image.qcow2
	@echo "Running $@"
	qemu-system-x86_64 --enable-kvm -m 15G -device virtio-balloon -smp 8 -cpu qemu64,smap,smep -nographic -device virtio-scsi-pci,id=scsi0 -drive file=backing-image.qcow2,if=none,id=drive0 -device scsi-hd,bus=scsi0.0,drive=drive0 -net nic,model=virtio -net user,hostfwd=tcp::2222-:22

.PHONY: run-current-image
run-current-image: current-image.qcow2
	@echo "Running $@"
	qemu-system-x86_64 --enable-kvm -m 15G -device virtio-balloon -smp 8 -cpu qemu64,smap,smep -nographic -device virtio-scsi-pci,id=scsi0 -drive file=current-image.qcow2,if=none,id=drive0 -device scsi-hd,bus=scsi0.0,drive=drive0 -net nic,model=virtio -net user,hostfwd=tcp::2222-:22

.PHONY: help
help:
	@awk -F ':|##' '/^[^\t].+?:.*?##/ {printf "\033[36m%-25s\033[0m %s\n", $$1, $$NF}' $(MAKEFILE_LIST)