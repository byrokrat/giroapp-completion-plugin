# giroapp-completion-plugin

[![Build Status](https://img.shields.io/travis/byrokrat/giroapp-completion-plugin/master.svg?style=flat-square)](https://travis-ci.org/byrokrat/giroapp-completion-plugin)

Giroapp shell completion plugin.

```shell
make install
```

Add the following to `.bashrc` (requires giroapp to be installed as `giroapp`).

```shell
source $(giroapp _complete --generate-bash-script --app-name=giroapp)
```
