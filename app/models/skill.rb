class Skill
    def initialize(hash)
    @student_id = hash["student_id"]
    @skill_name = hash["skill_name"]
  end

  def self.find(id)
    Skill.new(Unirest.get("https://****PUT*HEROKU*HERE****/skills/#{id}").body)
  end

  def self.all
    api_students_array = Unirest.get("https://****PUT*HEROKU*HERE****/skills").body
    students = []
    api_students_array.each do |api_student|
      students << Student.new(api_student)
    end
    return students
  end
end