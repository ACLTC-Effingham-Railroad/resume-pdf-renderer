class Education

  attr_accessor :start_date, :end_date, :degree, :university_name, :details

  def initialize(hash)
    @start_date = hash["start_date"]
    @end_date = hash["end_date"]
    @degree = hash["degree"]
    @university_name = hash["university_name"]
    @details = hash["details"]
  end

  def self.find(id)
    Education.new(Unirest.get("https://****PUT*HEROKU*HERE****/educations/#{id}").body)
  end

  def self.all
    api_educations_array = Unirest.get("https://****PUT*HEROKU*HERE****/students").body
    educations = []
    api_educations_array.each do |api_education|
      educations << Education.new(api_education)
    end
    return educations
  end  


end