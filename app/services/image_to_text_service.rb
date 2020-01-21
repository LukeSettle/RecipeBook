class ImageToTextService
  include Rails.application.routes.url_helpers

  def initialize(image)
    @image = image
  end

  def text_from_image
    path = ActiveStorage::Blob.service.send(:url, @image.key)
    image = RTesseract.new(path)
    image.to_s
  end
end