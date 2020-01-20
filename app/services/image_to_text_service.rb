class ImageToTextService
  include Rails.application.routes.url_helpers

  def initialize(image)
    @image = image
  end

  def text_from_image
    active_storage_disk_service = ActiveStorage::Service::DiskService.new(root: Rails.root.to_s + '/storage/')
    path = active_storage_disk_service.send(:path_for, @image.blob.key)
    image = RTesseract.new(path)
    image.to_s
  end
end