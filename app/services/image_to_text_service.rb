class ImageToTextService
  include Rails.application.routes.url_helpers

  def initialize(image)
    @image = image
  end

  def text_for_image
    path = rails_blob_path(@image, disposition: "attachment", only_path: true)
    image = RTesseract.new(Rails.root.join('recipe_cards', 'typed-cards.jpg'))
    image.to_s
  end
end