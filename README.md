# InChI Grammar

Documentation of InChI syntax as a formal grammar in [W3C EBNF notation](https://www.w3.org/TR/REC-xml/#sec-notation). This work in progress currently recognizes the prefix, formula (partial), connections, and h\_atoms layers.

## Run Tests

The test suite is written in Ruby and uses the [EBNF gem](https://github.com/dryruby/ebnf). Test strings are contained in [strings.txt](strings.txt). To install the harness and run the tests:

```bash
cd test
bundle install --path vendor/bundle
ruby test.rb
```

# License

InChI Grammar is distributed under the terms of the MIT License. See [LICENSE-MIT](LICENSE-MIT) and [COPYRIGHT](COPYRIGHT) for details
