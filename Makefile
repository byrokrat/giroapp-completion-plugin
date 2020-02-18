COMPOSER_CMD=composer
PHIVE_CMD=phive
GIROAPP_CMD=tools/giroapp
BOX_CMD=tools/box

.DEFAULT_GOAL=all

TARGET=giroapp-completion-plugin.phar
SRC_FILES:=$(shell find src/ -type f -name '*.php')

$(TARGET): $(SRC_FILES) stub.php box.json composer.lock vendor/installed $(BOX_CMD)
	$(BOX_CMD) compile

.PHONY: all
all: test

.PHONY: build
build: $(TARGET)

.PHONY: test
test: install_test giroapp.ini $(GIROAPP_CMD)
	@echo Testing completion output using "_complete 'giroapp tran' 11"
	test "$(shell export GIROAPP_INI=giroapp.ini; $(GIROAPP_CMD) _complete 'giroapp tran' 11 | xargs)" = "transactions"
	@echo OK

.PHONY: install_test
install_test: $(TARGET) giroapp.ini $(GIROAPP_CMD)
	cp $< $(shell export GIROAPP_INI=giroapp.ini; $(GIROAPP_CMD) conf plugins_dir)

giroapp.ini: $(GIROAPP_CMD)
	rm -f $@
	$(GIROAPP_CMD) init
	echo 'org_bg = "111-1111"' >> $@
	echo 'org_id = "8350000892"' >> $@
	echo 'base_dir = "tmp"' >> $@

.PHONY: clean
clean:
	rm -rf tmp
	rm -rf tools
	rm -rf vendor
	rm -f $(TARGET)
	rm -f giroapp.ini
	rm -f phive.xml

.PHONY: install
install: $(TARGET) test $(GIROAPP_CMD)
	cp $< $(shell $(GIROAPP_CMD) conf plugins_dir)

.PHONY: uninstall $(GIROAPP_CMD)
uninstall:
	rm -f $(shell $(GIROAPP_CMD) conf plugins_dir)/$(TARGET)

composer.lock: composer.json
	@echo composer.lock is not up to date

vendor/installed: composer.lock
	$(COMPOSER_CMD) install
	touch $@

$(BOX_CMD):
	$(PHIVE_CMD) install humbug/box:3 --force-accept-unsigned

$(GIROAPP_CMD):
	$(PHIVE_CMD) install byrokrat/giroapp:1 --force-accept-unsigned
