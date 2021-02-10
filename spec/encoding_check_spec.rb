# frozen_string_literal: true

RSpec.describe Extensions::String::EncodingCheck do
  it "has a version number" do
    expect(Extensions::String::EncodingCheck::VERSION).not_to be nil
  end

  describe ".fix_encoding!" do
    [Encoding::UTF_8, Encoding::ISO_8859_1].each do |string_encoding|
      [Encoding::UTF_8, Encoding::ISO_8859_1].each do |expected_encoding|
        context "given a #{string_encoding} string with #{expected_encoding} expected encoding" do
          is_required_fix = (string_encoding != expected_encoding)
          it is_required_fix ? "fix encoding to #{string_encoding}" : "don't fix encoding" do
            str = "cioè".encode(string_encoding)
            str.force_encoding expected_encoding if is_required_fix
            expect(str.fix_encoding!.encoding).to eq(string_encoding)
          end
        end
      end
    end
  end

  describe ".ensure_encoding!" do
    context "ensuring a utf-8 encoding of an iso-8859-1 string" do
      it "return a utf-8 string" do
        str = "cioè".encode(Encoding::ISO_8859_1)
        expect(str.ensure_encoding!(encoding: Encoding::UTF_8).encoding).to eq(Encoding::UTF_8)
      end
    end
  end
end
