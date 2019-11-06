@students = []  # an empty array accessible to all methods

def input_students
  puts "Please enter the names of the students and the month of their cohort"
  puts "To finish, just hit return twice"
  # get the first name
  puts "Name of student:"
  name = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    # get the cohort
    cohort = cohort_selection
    if cohort == false then redo end
    # add the student hash to the array
    @students << {name: name, cohort: cohort.to_sym}
    if @students.count == 1
      puts "Now we have #{@students.count} student"
    else
      puts "Now we have #{@students.count} students"
    end
    # get another name from the user
    puts "Name of student:"
    name = gets.chomp
  end
end

def interactive_menu
  loop do
    print_menu
    process(gets.chomp)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "9. Exit"
end

def show_students
  if !@students.empty?
    print_header
    print_student_list
    print_footer
  else
    puts "The student list is empty"
  end
end

def process(selection)
  case selection
    when "1"
      input_students
    when "2"
      show_students
    when "9"
      exit # this will cause the program to terminate
    else
      puts "I don't know what you meant, try again"
  end
end

def cohort_selection
  puts "Cohort of student:"
  cohort = gets.chomp.capitalize
  # if an invalid month/typo entered, it returns false
  require 'date'
  if !Date::MONTHNAMES.include?(cohort)
    puts "Invalid month given"
    false
  else cohort
  end
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print_student_list
  @students.each { |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  }
end

def print_footer
  if @students.count == 1
    puts "Overall, we have #{@students.count} great student"
  else
    puts "Overall, we have #{@students.count} great students"
  end
end

interactive_menu
