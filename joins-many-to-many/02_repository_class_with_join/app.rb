require_relative "lib/cohort_repository"
require_relative "lib/database_connection"

DatabaseConnection.connect("student_directory_2")

repo = CohortRepository.new
cohort = repo.find_with_students(3)

puts "=" * 25
puts "COHORT:        #{cohort.name}"
puts "STARTING DATE: #{cohort.starting_date}"
puts "=" * 25
puts "= STUDENTS              ="
puts "=" * 25
cohort.students.each do |student|
  puts " #{student.id} - #{student.name}"
end