SUBDIRS = hello

export CFLAGS := -Wall

export OUTPUT_APP := $(CURDIR)/../../output/app

all:
	for dir in $(SUBDIRS); do \
		cd $$dir ; \
		make -j 8 all; \
	done

clean:
	for dir in $(SUBDIRS); do \
		cd $$dir ; \
		make -j 8 clean; \
	done
