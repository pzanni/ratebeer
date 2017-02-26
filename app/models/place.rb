class Place < OpenStruct
  def self.rendered_fields
    [ :status, :street, :city, :zip, :country, :overall ]
  end 

  def address_line
    ERB::Util.url_encode("#{street} #{city} #{country}") 
  end

  def url
    "//www.google.com/maps/embed/v1/place?q=#{address_line}&zoom=17&key='AIzaSyA8wer1xLTA8y2_mseZpG0x8e1NllhvD0g'"
  end 
end