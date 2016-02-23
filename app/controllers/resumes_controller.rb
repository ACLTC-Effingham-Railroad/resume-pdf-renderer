class ResumesController < ApplicationController

  def index

    @students = Unirest.get("https://calm-wildwood-62465.herokuapp.com/students").body

  end

  def show
    student = Unirest.get("https://calm-wildwood-62465.herokuapp.com/students/#{params[:id]}").body

    experiences = student["experiences"]
    educations = student["educations"]
    skills = student["skills"]
    capstones = student["capstones"]

    pdf = Prawn::Document.new

    require "open-uri"
    pdf.image open(student["photo"]), :scale =>0.25

    pdf.move_up 70

    pdf.font_size 30
    pdf.text student["first_name"] + " " + student["last_name"],  align: :center, styles: [:bold], :color => "137abf"
    pdf.font_size 15
    pdf.text student["phone_number"] + " | " + student["email"], align: :center

    pdf.move_down 25
    pdf.font_size 15
    pdf.text "Summary:", align: :center, styles: [:bold], :color => "137abf"
    pdf.font_size 12
    pdf.text student["short_bio"], align: :center

    pdf.move_down 20
    pdf.font_size 15
    pdf.text "On the web:", align: :center, :color => "137abf"
    pdf.font_size 10
    pdf.text "Linked In: " + student["linkedin_url"], align: :center
    pdf.text "Twitter: " + student["twitter_handle"], align: :center

    pdf.text "My Blog: " + student["blog_url"], align: :center
    pdf.text "My Online Resume: " + student["online_resume_url"], align: :center
    pdf.text "Github: " + student["github_url"], align: :center

    pdf.move_down 20
    pdf.font_size 15
    pdf.text "Experience:", align: :center, styles: [:bold], :color => "137abf"
    pdf.font_size 12

    experiences.each do |experience|
      pdf.move_down 10 
      pdf.text experience["job_title"] + " | " + experience["company_name"], style: :bold
      pdf.text friendly_date(experience["start_date"]) + " - " + friendly_date(experience["end_date"])
      pdf.move_down 5
      pdf.text experience["details"]
    end

    pdf.move_down 10
    pdf.stroke_horizontal_rule

    pdf.move_down 20
    pdf.font_size 15
    pdf.text "Education:", align: :center, styles: [:bold], :color => "137abf"
    pdf.font_size 12

    educations.each do |education|
      pdf.move_down 10 
      pdf.text education["university_name"], style: :bold
      pdf.text education["degree"]
      pdf.text friendly_date(education["start_date"]) + " - " + friendly_date(education["end_date"])
      pdf.text education["details"]
    end

    pdf.move_down 10
    pdf.stroke_horizontal_rule

    pdf.move_down 20
    pdf.font_size 15
    pdf.text "Skills:", align: :center, styles: [:bold], :color => "137abf"
    pdf.font_size 12

    skills.each do |skill|
      pdf.move_down 10 
      pdf.text "* " + skill["skill_name"]
    end

    pdf.move_down 10
    pdf.stroke_horizontal_rule

    pdf.move_down 20
    pdf.font_size 15
    pdf.text "Projects:", align: :center, styles: [:bold], :color => "137abf"
    pdf.font_size 12

    capstones.each do |capstone|
      pdf.move_down 10 
      pdf.text capstone["name"]
      pdf.text capstone["description"]
      pdf.text capstone["url"]
      pdf.image open(capstone["screenshot"]), :scale =>0.25
    end

    send_data pdf.render, type: "application/pdf", disposition: "inline"
  end

end

