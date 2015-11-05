<!-- [![NPM version](https://badge.fury.io/js/my-bash-scripts.svg)](http://badge.fury.io/js/my-bash-scripts)
[![npm module downloads per month](http://img.shields.io/npm/dm/my-bash-scripts.svg)](https://www.npmjs.org/package/my-bash-scripts)
[![Build Status](https://travis-ci.org/kaelzhang/my-bash-scripts.svg?branch=master)](https://travis-ci.org/kaelzhang/my-bash-scripts)
[![Dependency Status](https://gemnasium.com/kaelzhang/my-bash-scripts.svg)](https://gemnasium.com/kaelzhang/my-bash-scripts) -->

# my-bash-scripts

My bash scripts.

## Install

Adds to ~/.bash_profile file:

```sh
# my bash scripts
if [[ -f ~/path/to/my-bash-scripts/main.sh ]]; then
  export MY_BASH_SCRIPTS_DIR=$(cd ~/path/to/my-bash-scripts && pwd)
  source ~/path/to/my-bash-scripts/main.sh
fi
```

## Usage

```js
var my_bash_scripts = require('my-bash-scripts');
```

## License

MIT
