Given /^a ([^ ]+) file containing the string "([^"]*)"$/ do |encoding, str|
  @temp_file = Tempfile.new('encoding_check', encoding: encoding)
  @temp_file.write(str)
  @temp_file.close
end

When /I ensure it to be encoded in (\S+)/ do |encoding|
  run_command_and_stop("encoding_check ensure #{@temp_file.path} #{encoding}", fail_on_error: true)
end

Then /the output should be "([^"]*)"$/ do |str|
  expect(last_command_started.output).to eq(eval("\"#{str.gsub(/"/, '\"')}\"") + "\n")
end
