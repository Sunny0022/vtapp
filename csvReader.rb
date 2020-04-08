require 'csv'
class CSVReader
  def read(file)
    CSV.foreach(file,  headers: true) do |row|
      @name = row[0]
      @empId = row[1]
      @designation = row[2]
      Employee.new(@name, @empId, @designation)
    end
  end
end
class Employee

  attr_accessor :name, :empId, :designation

  def initialize(name, empId, designation)
    @name = name
    @empId = empId
    @designation = designation
  end

  def self.export_file_into_csv
    data = Array.new
    ObjectSpace.each_object(self) do |obj|
      data << [obj.name, obj.empId, obj.designation]
    end
    body = data.sort_by! { |row| row[2] }
    grouped_details = body.group_by { |row| row[2] }
    details = grouped_details.each do |key, value|
      value.sort_by! { |row| row[1] }
    end
    File.open('employees.csv', 'w') do |file|
      details.each do |designation, value|
        file.puts "#{designation}#{"s" if details[designation].length > 1}"
        value.each { |detail| file.puts "#{detail[0]} (EmpId: #{detail[1]})" }
      file.puts
      end
    end
  end
end
new_csv = CSVReader.new
new_csv.read('test.csv') # instance method
Employee.export_file_into_csv # class method
