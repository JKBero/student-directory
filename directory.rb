def input_students
  puts "Please enter the names of the students and the month of their cohort"
  puts "To finish, just hit return twice"
  # create an empty array
  students = []
  # get the first name
  puts "Name of student:"
  name = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    # get the cohort
    puts "Cohort of student:"
    cohort = gets.chomp.capitalize
    # if cohort is empty, sets default month
    if cohort.empty? then cohort = "January" end
    # if an invalid month/typo entered, it redoes loop
    require 'date'
    if !Date::MONTHNAMES.include?(cohort)
      puts "Invalid month given"
      redo
    end
    # add the student hash to the array
    students << {name: name, cohort: cohort.to_sym}
    if students.count == 1
      puts "Now we have #{students.count} student"
    else
      puts "Now we have #{students.count} students"
    end
    # get another name from the user
    puts "Name of student:"
    name = gets.chomp
  end
  # return the array of students
  students
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print(students)
  students.each { |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  }
end

def print_footer(students)
  if students.count == 1
    puts "Overall, we have #{students.count} great student"
  else
    puts "Overall, we have #{students.count} great students"
  end
end

students = input_students
# nothing happens until we call the methods
if !students.empty?
  print_header
  print(students)
  print_footer(students)
end
