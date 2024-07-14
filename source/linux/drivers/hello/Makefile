# Makefile for the out of tree hello driver.
#

ifneq ($(KERNELRELEASE),)
obj-m := hello.o
else
KDIR := /home/ngoc/Workspace/projects/bbb-linux/source/linux/
all:
	$(MAKE) -C $(KDIR) M=$$PWD
endif
