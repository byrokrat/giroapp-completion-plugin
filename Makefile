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
test: setup_test_env $(GIROAPP_CMD)
	@echo Testing completion output using "_complete 'giroapp stat' 11"
	test "$(shell export GIROAPP_INI=giroapp.ini; $(GIROAPP_CMD) _complete 'giroapp stat' 11 | xargs)" = "status"
	@echo OK

.PHONY: setup_test_env
setup_test_env: $(TARGET) giroapp.ini
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

tools/installed:
	$(PHIVE_CMD) install --force-accept-unsigned
	touch $@

$(BOX_CMD): tools/installed
$(GIROAPP_CMD): tools/installed
