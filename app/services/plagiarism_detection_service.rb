require 'pdf-reader'
require 'tf-idf-similarity'
require 'matrix'

class PlagiarismDetectionService
  def self.call(submission)
    new.call(submission)
  end

  def call(main_submission)
    main_text = extract_text(main_submission.file)
    main_doc = TfIdfSimilarity::Document.new(main_text)

    other_submissions = CourseMaterialSubmission.where(course_material_id: main_submission.course_material_id).where.not(id: main_submission.id).to_a

    corpus = [main_doc] + other_submissions.map { |s| TfIdfSimilarity::Document.new(extract_text(s.file)) }
    model = TfIdfSimilarity::TfIdfModel.new(corpus)
    matrix = model.similarity_matrix

    similarities = other_submissions.each_with_index.map do |submission, index|
      similarity = matrix[model.document_index(main_doc), model.document_index(corpus[index + 1])]
      [submission, similarity]
    end

    similarities
      .select { |_, score| score >= 0.6 }
      .sort_by { |_, score| -score }
      .first(3)
      .map { |submission, score| { id: submission.id, similarity: (score * 100).round(2) } }
  end

  private

  def extract_text(attached_file)
    return '' unless attached_file.attached?

    file_path = ActiveStorage::Blob.service.send(:path_for, attached_file.key)
    reader = PDF::Reader.new(file_path)
    reader.pages.map(&:text).join(' ')
  rescue => e
    Rails.logger.error "❌ PDF parsing failed: #{e.message}"
    ''
  end
end
