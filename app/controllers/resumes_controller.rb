class ResumesController < ApplicationController
  def index
    # @students = Student.find(Unirest.get().body))

    pdf = Prawn::Document.new

    # Test Info for formatting
    pdf.font_size 30
    pdf.text "First and Last Name", align: :center, styles: [:bold]
    pdf.font_size 15
    pdf.text "555-555-5555" + " | " + "email@email.com", align: :center

    pdf.move_down 40
    pdf.font_size 20
    pdf.text "Short Bio:", align: :center
    pdf.font_size 15
    pdf.text "And that kind of sharing is hard to convey in a resume. Your bio needs to tell the bigger story. Especially, when you're in business for yourself, or in the business ..."
 
    pdf.render_file "example.pdf"
  end

  def show
    # @resume = Student.new(Unirest.get().body))
  end

end

