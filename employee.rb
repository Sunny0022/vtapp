require_relative('C:/Training/csv_new.rb')
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

employee = Employee.new
new_input = employee.create_new_csv
csv = CSV.new
csv.get_details_from_csv(new_input)
