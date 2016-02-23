class ResumesController < ApplicationController

  def index

    @students = Unirest.get("http://localhost:3001/students").body

  end

  def show
    student = Unirest.get("http://localhost:3001/students/#{params[:id]}").body

    experiences = student["experiences"]
    educations = student["educations"]
    skills = student["skills"]
    capstones = student["capstones"]

    pdf = Prawn::Document.new

      # require "open-uri"
      # pdf.image open("image_url"), :scale =>0.25

      # Test Info for formatting
    pdf.font_size 30
    pdf.text student["first_name"] + " " + student["last_name"],  align: :center, styles: [:bold], :color => "137abf"
    pdf.font_size 15
    pdf.text student["phone_number"] + " | " + student["email"], align: :center

    pdf.move_down 35
    pdf.font_size 15
    pdf.text "Summary:", align: :center, styles: [:bold], :color => "137abf"
    pdf.font_size 12
    pdf.text student["short_bio"], align: :center

    pdf.move_down 20
    pdf.font_size 15
    pdf.text "On the web:", align: :center, styles: [:bold], :color => "137abf"
    pdf.font_size 12
    pdf.text "Linked In: " + student["linkedin_url"] + " | " + "Twitter: " + student["twitter_handle"], align: :center

    pdf.text "My Blog: " + student["blog_url"] + " | " + "My Online Resume: " + student["online_resume_url"], align: :center

    pdf.move_down 20
    pdf.font_size 15
    pdf.text "Experience:", align: :center, styles: [:bold], :color => "137abf"
    pdf.font_size 12

    experiences.each do |experience|
      pdf.text experience["job_title"] + " | " + experience["company_name"], styles: [:bold]
      pdf.text experience["start_date"] + " - " + experience["end_date"]
      pdf.text experience["details"]
    end

    pdf.move_down 10
    pdf.stroke_horizontal_rule

    pdf.move_down 20
    pdf.font_size 15
    pdf.text "Education:", align: :center, styles: [:bold], :color => "137abf"
    pdf.font_size 12

    educations.each do |education|
      pdf.text education["university_name"]
      pdf.text education["degree"]
      pdf.text education["start_date"] + " - " + education["end_date"]
      pdf.text education["details"]
    end

    pdf.move_down 10
    pdf.stroke_horizontal_rule

    pdf.move_down 20
    pdf.font_size 15
    pdf.text "Skills:", align: :center, styles: [:bold], :color => "137abf"
    pdf.font_size 12

    skills.each do |skill|
      pdf.text skill["skill_name"]
    end

    send_data pdf.render, type: "application/pdf", disposition: "inline"
  end

end

