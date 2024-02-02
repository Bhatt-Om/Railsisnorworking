require "rqrcode"

class EventEnroll < ApplicationRecord
  belongs_to :user
  belongs_to :event
  has_many_attached :qrcodes, dependent: :destroy
  serialize :enroll_date, type: Array, coder: JSON
  serialize :present_dates, type: Hash, coder: JSON
  include Rails.application.routes.url_helpers

  after_create :set_present_dates
  after_create :generate_qr
  
  def as_json(options = {})
    super(options).merge(
      user: user,
      event: event,
      qrcodes_url: qrcodes_urls
    ) 
  end

  def set_present_dates
    enroll_date.present? ? ( enroll_date.each_with_object(present_dates) { |date, hash| hash[date] = false } ) : ""
    self.save!
  end

  def generate_qr
    enroll_date.each do |date|
      qrcode = RQRCode::QRCode.new("#{date}qrcode#{user.email}.png")
      png = qrcode.as_png(
        bit_depth: 1,
        border_modules: 4,
        color_mode: ChunkyPNG::COLOR_GRAYSCALE,
        color: 'black',
        file: nil,
        fill: 'white',
        module_px_size: 6,
        resize_exactly_to: false,
        resize_gte_to: false,
        size: 120
      )
      # Attach The Png To ActiveStorage
      self.qrcodes.attach(
        io: StringIO.new(png.to_s),
        filename: 'qrcode.png',
        content_type: 'image/png'
      )
      qrcodes.blobs.last.update(qr_date: date)
    end
  end

  private
  def qrcodes_urls
    qrcodes.attached? ? qrcodes.map { |qrcode| url_for(qrcode) } : ''
  end
end
