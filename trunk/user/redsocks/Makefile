THISDIR = $(shell pwd)

all:

romfs:
	$(ROMFSINST) $(THISDIR)/$(SRC_NAME)/redsocks /usr/bin/redsocks
	cp -fP $(STAGEDIR)/lib/libevent_core-2.1.so.* $(ROMFSDIR)/lib