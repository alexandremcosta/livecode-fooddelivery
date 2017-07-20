require_relative "../models/employee"

class EmployeeRepository
  def initialize(db)
    @db = db
    load
  end

  def find_by_username(username)
    @elements.find { |element| element.username == username }
  end

  def all_delivery_guys
    @elements.select { |element| element.delivery_guy? }
  end

  def all
    return @elements
  end

  def find(id)
    @elements.find { |element| element.id == id }
  end

  private

  def load
    employees = @db.execute("SELECT username, password, role FROM employees")

    @elements = employees.map do |elem|
      Employee.new(username: elem[0], password: elem[1], role: elem[2])
    end
  end
end
