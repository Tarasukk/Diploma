# frozen_string_literal: true

require 'prawn'

module PdfService
  module_function

  def generate_title_page(submission)
    student = submission.user
    material = submission.course_material
    course = material.course

    file = Tempfile.new([ 'title_page', '.pdf' ])
    file.binmode

    Prawn::Document.generate(file.path, page_size: 'A4', left_margin: 70) do |pdf|
      font_path = Rails.root.join('app/pdfs/fonts')
      pdf.font_families.update(
        'DejaVu' => {
          normal: "#{font_path}/DejaVuSans.ttf",
          bold: "#{font_path}/DejaVuSans-Bold.ttf"
        }
      )
      pdf.font("DejaVu")

      pdf.move_down 30
      pdf.text 'МІНІСТЕРСТВО ОСВІТИ І НАУКИ УКРАЇНИ', align: :center, size: 14
      pdf.text 'ЛЬВІВСЬКИЙ НАЦІОНАЛЬНИЙ УНІВЕРСИТЕТ ІМЕНІ ІВАНА ФРАНКА', align: :center, size: 14
      pdf.move_down 40
      pdf.text "Факультет #{course.department}", align: :center, size: 12

      pdf.move_down 100
      pdf.text 'Звіт', align: :center, size: 12
      pdf.move_down 10
      pdf.text "Про виконання лабораторної роботи №#{material.assignment_number}", align: :center, size: 12
      pdf.move_down 10
      pdf.text "\"#{material.topic}\"", align: :center, size: 12, style: :bold

      pdf.move_down 150
      pdf.text 'Виконав:', align: :right, size: 12
      pdf.text "Студент групи #{student.student_group.name}", align: :right, size: 12
      pdf.text "#{student.name}", align: :right, size: 12
      pdf.move_down 10
      pdf.text 'Перевірив:', align: :right, size: 12
      pdf.text "#{course.teacher.name}", align: :right, size: 12

      pdf.move_down 230
      pdf.text "Львів #{Date.today.year}", align: :center, size: 12
    end

    file.rewind
    file
  end

  def attach_title_page(submission)
    return unless submission.file.attached?

    original_filename = submission.file.filename.to_s
    title_page = generate_title_page(submission)
    combined = CombinePDF.new

    combined << CombinePDF.load(title_page.path)
    combined << CombinePDF.parse(submission.file.download)

    submission.file.purge
    submission.file.attach(
      io: StringIO.new(combined.to_pdf),
      filename: original_filename,
      content_type: 'application/pdf'
    )
  ensure
    title_page&.close
    title_page&.unlink
  end
end
