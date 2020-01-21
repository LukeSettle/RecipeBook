class ImageToTextService
  include Rails.application.routes.url_helpers

  def initialize(image)
    @image = image
  end

  def text_from_image
    path = rails_blob_path(@image)
    image = RTesseract.new(path)
    image.to_s
  end
end