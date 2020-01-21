class ImageToTextService
  include Rails.application.routes.url_helpers

  def initialize(image)
    @image = image
  end

  def text_from_image
    remote_path = rails_blob_url(@image)
    local_path = "#{SecureRandom.urlsafe_base64}.#{@image.filename.extension_without_delimiter}"
    download = open(remote_path)
    IO.copy_stream(download, local_path)
    tesseract = RTesseract.new(local_path)
    image_text = tesseract.to_s
    delete(local_path)
    image_text
  end
end