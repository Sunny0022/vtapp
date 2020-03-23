require 'csv'

class Employee

  def create_new_csv
    CSV.open('test.csv','wb') do |csv|
      csv << ['Name', 'EmpID', 'Designation']
      csv << ['Jack', '15', 'Developer']
      csv << ['Mary', '13', 'Designer']
      csv << ['John', '12', 'Developer']
      csv << ['Jane', '17', 'Designer']
      csv << ['Johny', '19', 'Tester']
  end
  end
  
  def read_csv_data(file)
    CSV.read('test.csv', headers: true)
  end

  def extract_details(data)
    body = data.to_a[1..-1]
  end

  def sort_details(body)
    body.sort_by! { |row| row[2] }
  end

  def group_details(body)
    grouped_details = body.group_by { |row| row[2] }
    grouped_details.each do |key, value|
      value.sort_by! { |row| row[1] }
    end
  end

  def export_details(details)
    File.open("new_format.csv", "w") do |file|
      details.each do |designation, value|
        file.puts "#{designation}#{"s" if details[designation].length > 1}"
        value.each { |detail| file.puts "#{detail[0]} (EmpId: #{detail[1]})" }
        file.puts
      end
    end
  end

  def get_details_from_csv(file)
    data = read_csv_data(file)
    details = extract_details(data)
    details = sort_details(details)
    grouped_details = group_details(details)
    export_details(grouped_details)
  end
end
employee = Employee.new
employee.get_details_from_csv('test.csv')
