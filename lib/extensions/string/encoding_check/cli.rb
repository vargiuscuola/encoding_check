require 'thor'
require 'encoding_check'

module Extensions
  module String
    module EncodingCheck
        
      class CLI < Thor
        
        desc "fix FILE", "Fix encoding of provided file"
        def fix(file)
          puts File.read(file).fix_encoding!
        end

        desc "ensure FILE [ENCODING]", "Print the input file encoded in the provided encoding"
        def ensure(file, encoding="utf-8")
          puts File.read(file).ensure_encoding!(encoding: encoding)
        end

      end
    
    end
  end
end
