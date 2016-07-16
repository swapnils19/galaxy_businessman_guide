# This module contains methods to manipulate and get Decimal numbers from given Roman numbrs
module NumbersUtil
  
  # Roman number constants
  ROMAN_NUMBERS = {
  	'I' => 1,
  	'V' => 5,
	  'X' => 10,
	  'L' => 50,
	  'C' => 100,
	  'D' => 500,
	  'M' => 1000
  }

  # Roman numbers those are allowed to be repeated
  REPEAT_CHARS = ['I', 'X', 'C', 'M']

  # This method will return the Decimanl value of a given Roman number
  # The method will also check for valid repeated occurances of a character
  #   in a submitted Roman number
  # Parameters - 
  #   roman_number: String
  def self.get_roman_number_value(roman_number: '')
    dec_number = 0
    dec_num_array = []
    char_repeated = 0
    roman_number.each_char.with_index do |num, i|
      if (roman_number[i] == roman_number[i+1])
        char_repeated +=1
        raise "Number #{num} repeated #{char_repeated} times" if char_repeated > 3
        raise "Number #{num} should not be repeated" unless REPEAT_CHARS.include?(num)
      else
        char_repeated = 0
      end

      if(ROMAN_NUMBERS.has_key?(num))
        val = ROMAN_NUMBERS.fetch(num)
        dec_num_array << val
      else
        raise StandardError
      end
    end
    dec_number = check_rules(dec_num_array: dec_num_array)
    return dec_number
  rescue StandardError => e
    puts e
    puts "Invalid Roman number - #{roman_number}"
  end

  # This method will check basic rules to operate on roman numbers
  # The method will return a valid Decimal number converted
  # Parameters - 
  #   dec_num_array: Array
  def self.check_rules(dec_num_array: [])
    dec_number = 0
    flag_next = false
    dec_num_array.each_with_index do |num, i|
      if flag_next
        flag_next = false
        next
      end
      num_next = dec_num_array[i+1] || 0
      if(num_next > num)
        if check_extended_rules(num_next: num_next, num_cur: num)
          dec_number += (num_next - num)
          flag_next = true
        end
      else
        dec_number += num
      end
    end
    return dec_number
  end

  # This method will check if the can be subtracted or not
  # The method will return `true` if the number can be subtracted
  # Parameters - 
  #   num_next: Integer
  #   num_cur: Integer
  def self.check_extended_rules(num_next: 0, num_cur: 0)
    case num_cur
    when ROMAN_NUMBERS['I']
      is_valid = [ROMAN_NUMBERS['V'],ROMAN_NUMBERS['X']].include?(num_next) ? true : false
      return is_valid
    when ROMAN_NUMBERS['X']
      is_valid = [ROMAN_NUMBERS['L'],ROMAN_NUMBERS['C']].include?(num_next) ? true : false
      return is_valid
    when ROMAN_NUMBERS['C']
      is_valid = [ROMAN_NUMBERS['D'],ROMAN_NUMBERS['M']].include?(num_next) ? true : false
      return is_valid
    else
      return false
    end
  end
end