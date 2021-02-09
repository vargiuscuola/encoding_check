require_relative "encoding_check/version"

# Extensions
module Extensions
  # String
  module String
    # EncodingCheck
    module EncodingCheck
      
      PRIORITY_ENCODINGS = [ Encoding::ISO_8859_1 ]
      DEFAULT_ENCODING = Encoding::UTF_8

      class Error < StandardError; end
      encoding = "UTF-8"

      # Fix encoding of a string
      #
      # Fix encoding of a string if it doesn't have a valid encoding.
      # If the string is encoded in `ISO-8859-<n>`, force its encoding to `UTF-8` if it's a valid `UTF-8` string.
      #
      # @param [Array] try_encodings (optional)
      #   The encodings to try if the string doesn't have a valid encoding, before resort to `rchardet19` library
      def fix_encoding!(try_encodings: PRIORITY_ENCODINGS)
        if encoding.to_s =~ /^iso-8859-/i
          force_encoding(Encoding::UTF_8) if dup.force_encoding(Encoding::UTF_8).valid_encoding?
        elsif !valid_encoding?
          is_valid_encoding = try_encodings.find do |enc|
            force_encoding enc
            valid_encoding?
          end
          force_encoding CharDet.detect(self).encoding unless is_valid_encoding
        end
        self
      end

      # Ensure encoding of a string
      #
      # Ensure that the string is correctly encoded with the provided encoding.
      # If needed, it fixes the encoding of string with `fix_encoding!` before converting his encoding.
      #
      # @param [Encoding] encoding (optional)
      #   The encoding to ensure
      #
      # @param [Array] try_encodings (optional)
      #   The encodings to try in fixing the encoding with `fix_encoding!`
      def ensure_encoding!(encoding: DEFAULT_ENCODING, try_encodings: PRIORITY_ENCODINGS)
        fix_encoding!
        encode! encoding
        self
      end

    end
  end
end

String.include Extensions::String::EncodingCheck
