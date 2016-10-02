# https://github.com/noffle/common-readme

define README_TEXT
# whatever project

> one-liner description of the module

## Background

background details relevant to understanding what this module does

## Usage

Let's do X:

```js
var whateverProject = require('whatever project')

console.log('hello warld')
```

This will output

```
hello warld
```

## API

```js
var whateverProject = require('whatever project')
```

See [api_formatting.md](api_formatting.md) for tips.

## Install

With [npm](https://npmjs.org/) installed, run

```
$ npm install whatever project
```

## Acknowledgments

whatever project was inspired by..

## See Also

- [`noffle/common-readme`](https://github.com/noffle/common-readme)
- ...

## License

agplv3
endef

README.md:
	@echo == Writing template README.md
	@echo -e "$(subst $(newline),\n,${README_TEXT})" \
	> README.md
