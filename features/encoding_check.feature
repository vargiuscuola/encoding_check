Feature: String Encoding

  Scenario: Ensure a iso-8859-1 file is utf-8 encoded
    Given a iso-8859-1 file containing the string "Cioè"
    When I ensure it to be encoded in utf-8
    Then the output should be "Cioè"

  Scenario: Ensure a utf-8 file is iso-8859-1 encoded
    Given a utf-8 file containing the string "Cioè"
    When I ensure it to be encoded in iso8859-1
    Then the output should be "Cio\xE8"
