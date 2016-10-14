require 'test_helper'

class GalaxyBusinessmanGuideTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::GalaxyBusinessmanGuide::VERSION
  end

  def test_get_merchants_guide
    expected_output = "pish tegj glob glob is 42
glob prok Silver is 68
glob prok Gold is 57800
glob prok Iron is 782
I have no idea what you are talking about
"
    guide = GalaxyBusinessmanGuide.get_merchants_guides(file_name: File.join(File.dirname(__FILE__), "../input.txt"))
    assert_equal expected_output, guide
  end

  def test_get_roman_number
    roman_number = 'MCMIII'
    expected_dec_number = 1903
    actual_dec_number = GalaxyBusinessmanGuide.get_roman_number(roman_number: roman_number)
    assert_equal expected_dec_number, actual_dec_number
  end
end
