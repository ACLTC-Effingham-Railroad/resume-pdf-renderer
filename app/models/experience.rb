class Experience

  attr_accessor :start_date, :end_date, :job_title, :company_name, :details

  def initialize(hash)
    @start_date = hash["start_date"]
    @end_date = hash["end_date"]
    @job_title = hash["job_title"]
    @company_name = hash["company_name"]
    @details = hash["details"]
  end

  def self.find(id)
    Experience.new(Unirest.get("https://****PUT*HEROKU*HERE****/educations/#{id}").body)
  end

  def self.all
    api_expierences_array = Unirest.get("https://****PUT*HEROKU*HERE****/students").body
    experiences = []
    api_educations_array.each do |api_experience|
      experiences << Experience.new(api_experience)
    end
    return experiences
  end  


end