class Student

  attr_accessor :name, :grade
  attr_reader :id

  @@all = []

  def initialize(name, grade, id=nil)
    @name = name
    @grade = grade
    @id = nil
  end

  def self.all
    @@all
  end

  def self.create_table
    sql = "CREATE TABLE students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade INTEGER
    )"
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = "DROP TABLE Students"

    DB[:conn].execute(sql)
  end

  def save
    sql = <<-SQL
      INSERT INTO students (name, grade) 
      VALUES (?, ?)
    SQL
 
    DB[:conn].execute(sql, self.name, self.grade)

    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end

  def self.create(name:, grade:)
    stu = Student.new(name, grade)
    stu.save
    stu
  end

  
end
