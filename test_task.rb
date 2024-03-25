# frozen_string_literal: true

require 'date'

# license_class
class Flussonic
  attr_accessor :paid_till, :max_version, :min_version
end

license = Flussonic.new

puts 'Input the current date in a format like this: "1.10.2024"'
current_date_str = gets
current_date = Date.strptime(current_date_str, '%d.%m.%Y')

puts 'Input the paid till date in the same format'
paid_till_str = gets
license.paid_till = Date.strptime(paid_till_str, '%d.%m.%Y')

puts 'Input the max version'
license.max_version = gets.chomp

puts 'Input the min version'
license.min_version = gets.chomp

puts 'Input n'
n = gets.chomp.to_i

available_licenses = []
last_n_licenses = []
(0...n).each do |i|
  last_n_licenses[i] = current_date.prev_month(i).strftime('%y.%m')
end

if license.max_version == '' || license.min_version == ''
  last_n_licenses.each_index do |i|
    if Date.strptime(last_n_licenses[i], '%y.%m') <= license.paid_till
      puts i
      available_licenses.append(last_n_licenses[i])
    end
  end
elsif last_n_licenses.include?(license.max_version)
  last_n_licenses.each_index do |i|
    if Date.strptime(last_n_licenses[i], '%y.%m') < Date.strptime(license.min_version, '%y.%m')\
       && license.min_version != ''
      break
    end

    if Date.strptime(last_n_licenses[i], '%y.%m') <= Date.strptime(license.max_version, '%y.%m')\
         && Date.strptime(last_n_licenses[i], '%y.%m') <= license.paid_till
      available_licenses.append(last_n_licenses[i])
    end
  end
else
  available_licenses.append(license.max_version)
end

puts 'ANSWER:'
available_licenses.each { |i| print i, ', ' }
