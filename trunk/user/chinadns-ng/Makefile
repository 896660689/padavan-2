SRC_NAME = chinadns-ng-master
SRC_URL=https://github.com/zfl9/chinadns-ng/archive/master.zip

THISDIR = $(shell pwd)

CDN_HOME=chinadns

all: chinadns_dl download_test extract_test
	$(MAKE) -j$(HOST_NCPU) -C $(SRC_NAME)/build

download_test:
	( if [ ! -f $(SRC_NAME).zip ]; then \
		wget -t5 --timeout=20 --no-check-certificate -O $(SRC_NAME).zip $(SRC_URL); \
	fi )

extract_test:
	( if [ ! -d $(SRC_NAME) ]; then \
		unzip $(SRC_NAME).zip; \
	fi )

chinadns_dl:
ifeq ($(CONFIG_FIRMWARE_INCLUDE_SHADOWSOCKS),y)
	( if [ -d $(CDN_HOME) ]; then \
		tar zcf chinadns.tar.gz $(CSN_HOME) ; \
	fi )
endif

all: 
	$(MAKE) -j$(HOST_NCPU) -C $(SRC_NAME)

clean:
	if [ -f $(SRC_NAME)/Makefile ] ; then \
		$(MAKE) -C $(SRC_NAME) clean ; \
	fi ; \
	rm -f config_done

romfs:
ifeq ($(CONFIG_FIRMWARE_INCLUDE_SHADOWSOCKS),y)
	chmod a+x ./chinadns/*
	$(ROMFSINST) $(THISDIR)/chinadns.tar.gz /etc_ro/chinadns.tar.gz
endif
	$(ROMFSINST) -p +x $(THISDIR)/$(SRC_NAME)/chinadns-ng /usr/bin/chinadns-ng
