require_relative "database_connection"
require_relative "cohort"
require_relative "student"

class CohortRepository
  def find_with_students(id)
    sql_query =
    "SELECT
      cohorts.id AS cohort_id,
      cohorts.name AS cohort_name,
      cohorts.starting_date,
      students.id AS student_id,
      students.name AS student_name
    FROM cohorts
    JOIN students
      ON cohorts.id = students.cohort_id
    WHERE cohorts.id = $1;"
    query_result = DatabaseConnection.exec_params(sql_query, [id])

    cohort = Cohort.new
    cohort.id = query_result.first["cohort_id"].to_i
    cohort.name = query_result.first["cohort_name"]
    cohort.starting_date = query_result.first["starting_date"]

    query_result.each do |record|
      cohort.students << extract_student(record)
    end
    
    return cohort
  end

  private 

  def extract_student(record)
    student = Student.new
    student.id = record["student_id"].to_i
    student.name = record["student_name"]
    student.cohort_id = record["cohort_id"].to_i
    return student
  end
end