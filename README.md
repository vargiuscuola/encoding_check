# EncodingCheck

<p align="left">
  <a href="https://github.com/vargiuscuola/encoding_check"><img alt="encoding_check Rake Task Action Status" src="https://github.com/vargiuscuola/encoding_check/workflows/RakeTask/badge.svg"></a>
</p>

Gem library to help ensure and/or fix encoding of a string.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "encoding_check", "~> 0.2", git: "git@github.com:vargiuscuola/encoding_check.git", branch: :main
```

And then execute:

    $ bundle install

## Usage

### From ruby code

Load the extension:

```ruby
irb
> String.include Extensions::String::EncodingCheck
 => String
```
 
then you call the methods `fix_encoding!` and `ensure_encoding!` on strings.

Let's suppose you have a string loaded from file or some other input with the wrong encoding:

```ruby
irb
> str = "cioè".encode Encoding::UTF_8
 => "cioè"
> str = str.force_encoding Encoding::ISO_8859_1
 => "cio\xC3\xA8"
> str.encoding
 => #<Encoding:ISO-8859-1>
> str
 => "cio\xC3\xA8"
```

The `UTF-8` string "cioè" is being wrongly interpreted as `ISO-8859-1`.
If we try to encode back to `UTF-8` we get the wrong string:

```ruby
> str.encode Encoding::UTF_8
 => "cioÃ¨"
```

We can fix the encoding with the `fix_encoding!` method (see the documentation for a better explanation):
 
```ruby
> str.fix_encoding!
 => "cioè"
> str.encoding
 => #<Encoding:UTF-8>
```

We can ensure the encoding of a string (after eventually fix it if wrongly encoded) with the `ensure_encoding!` method (see the documentation for a better explanation):
 
```ruby
> str = "cioè".encode Encoding::UTF_8
 => "cioè"
> str = str.force_encoding Encoding::ISO_8859_1
> str.ensure_encoding! encoding: Encoding::ISO_8859_1
 => "cio\xE8"
```

Now the string is correctly encoded as `ISO-8859-1`, also if rendered as `cio\xE8` instead of `cioè` only because of `irb` console only rendering the string as `UTF-8`.
We can encode back to `UTF-8`:

```ruby
> str.ensure_encoding! encoding: Encoding::UTF_8
 => "cioè"
```

In the last command we could also have been used `str.encode Encoding::UTF_8` as we know the encoding is now correct being checked and eventually fixed by the previous command `ensure_encoding!`.


### From console

```sh
$ encoding_check
Commands:
  encoding_check ensure FILE [ENCODING]  # Print the input file encoded in the provided encoding
  encoding_check fix FILE                # Fix encoding of provided file
  encoding_check help [COMMAND]          # Describe available commands or one specific command
```
