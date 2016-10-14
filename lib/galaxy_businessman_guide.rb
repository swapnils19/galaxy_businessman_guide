require_relative 'galaxy_businessman_guide/version'
require_relative 'galaxy_businessman_guide/input_processor'
require_relative 'galaxy_businessman_guide/numbers_util'

module GalaxyBusinessmanGuide

  # accepts file name from command line
  # the file should be available in a same directory
  FILE_NAME = ARGV[0]

  # This method will get the calculated merchant's guide
  def self.get_merchants_guides(file_name: '')
    file_path = file_name.size == 0 ? File.join(File.dirname(__FILE__), "../#{FILE_NAME}") : file_name
    InputProcessor.get_merchants_guide(input_file_path: file_path)
  end

  # This method will get the decimal value of a Roman number passed
  def self.get_roman_number(roman_number: '')
    NumbersUtil.get_roman_number_value(roman_number: roman_number)
  end
end

# comment following line while runing `rake test`
puts GalaxyBusinessmanGuide.get_merchants_guides
# puts GalaxyBusinessmanGuide.get_roman_number(roman_number: 'DICX')