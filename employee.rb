class Employee

  def create_new_csv
    file_to_save = CSV.open('test.csv','w+')
      file_to_save.puts('Name', 'EmpID', 'Designation')
      file_to_save.puts('Jack', '15', 'Developer')
      file_to_save.puts('Mary', '13', 'Designer')
      file_to_save.puts('John', '12', 'Developer')
      file_to_save.puts('Jane', '17', 'Designer')
      file_to_save.puts('Johny', '19', 'Tester')
      file_to_save.close
  end
end

class CSV
  def read_csv_data(file)
    CSV.read('file', headers: true)
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
new_input = employee.create_new_csv
csv = CSV.new
csv.get_details_from_csv(new_input)
