require_relative 'numbers_util'

# This module will process the input file
module InputProcessor

  # The method will read the input file and perform further number calculations
  # It will return the output of the processed input
  # Parameters - 
  #   file_path: String
  def self.get_merchants_guide(input_file_path: '')
    @merchants_guide = ''
    if (File.exist?(input_file_path) && !File.directory?(input_file_path))
      @token_values = {}
      @coin_values = {}

      File.open(input_file_path, "r") do |file|
        file.each_line do |file_line|
          calculate_guide(line_input: file_line)
        end
      end
    else
      puts "File does not exist at path #{input_file_path}"
    end
    @merchants_guide
  end

  # The method will process each line of the input file.
  # It will return the calculated guide of the merchant
  # Parameters -
  #   line_input: String
  def self.calculate_guide(line_input: '')
    tokens =  line_input.strip.split(' is ')
    unless tokens[0].include?(' ')
      @token_values["#{tokens[0]}"] = "#{tokens[1]}"
    else
      if line_input.include?('?')
        @merchants_guide << get_answer(question_tokens: tokens[1]) << "\n"
      else
        set_coins(coin_tokens: tokens[0], value_tokens: tokens[1])
      end
    end
  end

  # This method parses & sets Coins(Silver ,Gold, Iron) that are passed in the input file
  # Parameters -
  #   coin_tokens: String
  #   value_tokens: String
  def self.set_coins(coin_tokens: '', value_tokens: '')
    value = value_tokens.match(/\d+/)
    roman_number, coins = extract_roman_number(key_tokens: coin_tokens, remove_tokens: true)
    @coin_values[coins] = value.to_s.to_f / NumbersUtil.get_roman_number_value(roman_number: roman_number)
  end

  # This method will extract a Roman number from a line passed in param key_tokens
  # Parameters -
  #   key_tokens: String
  #   remove_tokens: boolean
  def self.extract_roman_number(key_tokens: '', remove_tokens: false)
    roman_number = ''
    key_tokens.split(' ').each do |key|
      if @token_values.key?(key)
        roman_number << @token_values[key]
        key_tokens.gsub!(key, '') if remove_tokens
      end
    end
    return roman_number, key_tokens.strip
  end

  # This method will return the expected answer of the merchant's problem
  # Parameters - 
  #   question_tokens: String
  def self.get_answer(question_tokens: '')
    answer = ''
    if question_tokens.nil?
      answer = 'I have no idea what you are talking about'
    else
      answer = "#{question_tokens.gsub('?', 'is')} "
      roman_number, coins = extract_roman_number(key_tokens: question_tokens, remove_tokens: true)
      dec_number = NumbersUtil.get_roman_number_value(roman_number: roman_number)
      coin = coins.gsub('?','').strip
      value = @coin_values.key?(coin) ? (@coin_values[coin] * dec_number).to_i : dec_number
      answer << "#{value}"
    end
    answer
  end
end