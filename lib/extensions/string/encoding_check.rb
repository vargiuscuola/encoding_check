require_relative "encoding_check/version"

# Extensions
module Extensions
  # String
  module String
    # EncodingCheck
    module EncodingCheck
      PRIORITY_ENCODINGS = [Encoding::ISO_8859_1].freeze
      DEFAULT_ENCODING = Encoding::UTF_8

      class Error < StandardError; end

      # Fix encoding of a string
      #
      # Force the encoding of a string to the most sensible value in my debatable opinion gained according to actual
      # everyday cases.
      # If the string is declared as encoded in `ISO-8859-<n>` (which make it always formally valid), force its
      # encoding to the default encoding `UTF-8` if it's a valid `UTF-8` string.
      # Otherwise, if the string doesn't have a valid encoding, attempt to fix it trying first to force encoding to
      # the priority encodings provided, and if those fail to be a valid encoding, the string is force encoded with
      # the encoding detected by the `rchardet19` library.
      #
      # @param [Array<Encoding, String>] try_encodings (optional)
      #   The encodings to try if the string doesn't have a valid encoding, before resort to the detection of
      #   `rchardet19` library
      # @return self
      def fix_encoding!(try_encodings: PRIORITY_ENCODINGS)
        if encoding.to_s =~ /^iso-8859-/i
          force_encoding(DEFAULT_ENCODING) if dup.force_encoding(DEFAULT_ENCODING).valid_encoding?
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
      # @param [Array<Encoding, String>] try_encodings (optional)
      #   The encodings to try in the attempt to fix the encoding with `fix_encoding!` method
      # @return self
      # (see #fix_encoding!)
      def ensure_encoding!(encoding: DEFAULT_ENCODING, try_encodings: PRIORITY_ENCODINGS)
        fix_encoding!(try_encodings: try_encodings)
        encode! encoding
        self
      end
    end
  end
end

String.include Extensions::String::EncodingCheck
