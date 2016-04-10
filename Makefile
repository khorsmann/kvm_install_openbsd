# - Makefile to create OpenBSD guest VM with serial console

# - DOMAIN name is also used as disk image file ....


#URL		= http://ftp.halifax.rwth-aachen.de/openbsd/5.9/i386

URL		= /opt/images/install59.iso
BRIDGE		= virbr0
DOMAIN		= openbsd59
IMAGEDIR	= /var/lib/libvirt/images
IMAGEFILE	= ${IMAGEDIR}/${DOMAIN}.img
SIZE		= 30
MAC		= 52:54:00:5c:cf:44
VNCPASSWORD	= VERYSECRET
VNCPORT		= 5933
GRAPH		= vnc
DEBUG		= --dry-run
DEBUG		=

#GRAPH		= "vnc,listen=0.0.0.0,password=${VNCPASSWORD},port=${VNCPORT},keymap=de --noautoconsole"
#	--serial tcp,host=127.0.0.1:4000,mode=bind,protocol=telnet
#	--os-type=none 
#	--noautoconsole
#	--host-device 0x403:0x6001 
#	--serial dev,path=/dev/ttyS0 \
#	--cdrom=${URL} \
# 	--disk path=${IMAGEDIR}/${DOMAIN}_ports,size=8 \

create	:
	virt-install \
	--connect=qemu:///system \
	--name="${DOMAIN}" \
	--ram=2048 \
	--vcpus=2 \
	--description 'OpenBSD virt-install with serial' \
	--os-type=unix \
	--os-variant=openbsd4 \
	--pxe \
	--disk path=${IMAGEFILE},size=${SIZE} \
	--network bridge=${BRIDGE},model=virtio,mac=${MAC} \
	--graphics ${GRAPH} \
	--console pty,target_type=serial \
	${DEBUG}

lsimg	:      
	ls -ltr ${IMAGEDIR}

list	:
	virsh list --all

start	:
	virsh start ${DOMAIN} 

shutdown:
	virsh shutdown ${DOMAIN}

undefine:
	#virsh shutdown ${DOMAIN}
	#virsh destroy ${DOMAIN}
	virsh undefine ${DOMAIN} 
	rm -rf ${IMAGEFILE} 

info:
	virsh dominfo ${DOMAIN}

dumpxml:
	virsh dumpxml ${DOMAIN}

sysinfo:
	virsh sysinfo

version:
	libvirtd --version
	virsh --version
	virt-install --version
	virt-xml-validate --version
	virt-clone --version
	virt-manager --version
	#virt-top --version
	#virt-df --version

