class Student

  attr_reader :id
  attr_accessor :first_name, :last_name, :email, :phone_number, :short_bio, :linkedin_url, :twitter_handle, :blog_url, :online_resume_url, :github_url

  def initialize(hash)
    @id = hash["id"]
    @first_name = hash["first_name"]
    @last_name = hash["last_name"]
    @email = hash["email"]
    @phone_number = hash["phone_number"]
    @short_bio = hash["short_bio"]
    @linkedin_url = hash["linkedin_url"]
    @twitter_handle = hash["twitter_handle"]
    @blog_url = hash["blog_url"]
    @online_resume_url = hash["online_resume_url"]
    @github_url = hash["github_url"]
  end

  def self.find(id)
    Student.new(Unirest.get("https://****PUT*HEROKU*HERE****/students/#{id}").body)
  end

  def self.all
    api_students_array = Unirest.get("https://****PUT*HEROKU*HERE****/students").body
    students = []
    api_students_array.each do |api_student|
      students << Student.new(api_student)
    end
    return students
  end

end