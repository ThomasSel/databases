require "cohort_repository"
require "database_connection"

def reset_tables
  seed_sql = File.read('spec/seeds_student_database.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'student_directory_2' })
  connection.exec(seed_sql)
end

RSpec.describe CohortRepository do
  before(:each) do
    reset_tables
  end

  it "#find_with_students returns a cohort with an array of students" do
    cohort_repo = CohortRepository.new
    cohort = cohort_repo.find_with_students(2)

    expect(cohort.id).to eq 2
    expect(cohort.name).to eq "February"
    expect(cohort.starting_date).to eq "2023-02-01"

    expect(cohort.students.length).to eq 2
    expect(cohort.students.first.id).to eq 3
    expect(cohort.students.first.name).to eq "Student Three"
    expect(cohort.students.first.cohort_id).to eq 2
  end
end