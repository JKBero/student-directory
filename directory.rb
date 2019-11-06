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

def interactive_menu
  students = []
  loop do
    #1. print the menu and ask the user what to do
    puts "1. Input the students"
    puts "2. Show the students"
    puts "9. Exit"
    #2. read the input and save it into a variable
    selection = gets.chomp
    #3. do what the user has asked
    case selection
      when "1"
        students = input_students
      when "2"
        if !students.empty?
          print_header
          print(students)
          print_footer(students)
        end
      when "9"
        exit # this will cause the program to terminate
      else
        puts "I don't know what you meant, try again"
    end
  end
end

interactive_menu
