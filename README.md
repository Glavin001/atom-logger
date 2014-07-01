# [Atom-Logger](https://github.com/Glavin001/atom-logger) [![Build Status](https://secure.travis-ci.org/Glavin001/atom-logger.png?branch=master)](http://travis-ci.org/Glavin001/atom-logger)

> Reusable logging library for Atom packages.

## Getting Started

Install the module with: `npm install atom-logger --save`

Where `my-package` is your package name (settings namespace):

```coffee
Logger = require "atom-logger"
# Inside your Atom package's class
logger = new Logger atom.config, "my-package"
```

### API

Atom Logger acts as a layer on top of [Winston](https://github.com/flatiron/winston).
See the [Winston documentation](https://github.com/flatiron/winston) for more information.

## Examples

```coffeescript
Logger = require "atom-logger"
class MyPackage
  activate: () ->
    # Setup your Logger
    @logger = new Logger atom.config, "my-package"
    # Try logging with Winston!
    @logger.log 'info', "This is the message!", {"so":"meta"}
```

## Documentation

Use [Biscotto](https://github.com/atom/biscotto).

```bash
# Install CLI Globally
npm install -g biscotto
# Build documentation
biscotto
# Generated Documentation is in doc/ directory
```

## Contributing

- Use [CoffeeScript](https://github.com/caolan/nodeunit) with
[CoffeeLint](http://www.coffeelint.org/) for CoffeeScript source code linting.  
- Use [NodeUnit](https://github.com/caolan/nodeunit) for Unit Testing library.  
- Use [Biscotto's documentation notation](https://github.com/atom/biscotto) for documentation.  
- Use [Grunt-Conventional-Changelog](https://github.com/btford/grunt-conventional-changelog) for commit message conventions.  

## Release History

See [CHANGELOG.md](https://github.com/Glavin001/atom-logger/blob/master/CHANGELOG.md).

## License

Copyright (c) 2014 [Glavin Wiechert](https://github.com/Glavin001).  
Licensed under the MIT license.
