class ResumesController < ApplicationController
  def index
    # @student = Unirest.get().body

    # @experiences = @student["experience"]
    # @educations = @student["educations"]
    # @skills = @student["skills"]
    # @capstones = @student["capstones"]

    if params[:render]

      pdf = Prawn::Document.new

      # Test Info for formatting
      pdf.font_size 30
      pdf.text "First and Last Name", align: :center, styles: [:bold]
      pdf.font_size 15
      pdf.text "555-555-5555" + " | " + "email@email.com", align: :center

      pdf.move_down 40
      pdf.font_size 15
      pdf.text "Short Bio:", align: :center
      pdf.font_size 12
      pdf.text "And that kind of sharing is hard to convey in a resume. Your bio needs to tell the bigger story. Especially, when you're in business for yourself, or in the business ..."

      pdf.move_down 20
      pdf.font_size 15
      pdf.text "On the Interwebs:", align: :center, styles: [:italic]
      pdf.font_size 12
      pdf.text "Linked In: linkedin_url" + " | " + "Twitter: twitter_handle", align: :center
      pdf.text "My Blog: blog_url" + " | " + "My Online Resume: online_resume_url", align: :center

      pdf.move_down 20
      pdf.font_size 15
      pdf.text "Experience:", align: :center, styles: [:italic]
      pdf.font_size 12
  
      #experiences.each do |experience|
        pdf.text "Comapany Name"
        pdf.text "Job_title"
        pdf.text "Start_date" + " - " + "End_date"
        pdf.text "Details"
      #end

      send_data pdf.render, type: "application/pdf", disposition: "inline"

    end
  end

  def show
    # @student = Unirest.get().body

    # @experiences = @student["experience"]
    # @educations = @student["educations"]
    # @skills = @student["skills"]
    # @capstones = @student["capstones"]
  end

end

