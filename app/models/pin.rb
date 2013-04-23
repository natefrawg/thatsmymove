class Pin < ActiveRecord::Base

  attr_accessible :description, :image, :image_remote_url

	validates :description, presence: true
	validates :user_id, presence: true
	validates_attachment :image, presence: true, 
												content_type: { content_type: ['image/jpeg', 'image/jpg', 'image/png', 'image/gif', 'video/quicktime', 'video/mpeg', 'video/mp4']},
												size: { less_than: 15.megabytes }

	belongs_to :user
  
  has_attached_file :image, :styles => { 
  		:medium => { :geometry => "320x240", :format => 'mp4', :streaming => true },
			:thumb => { :geometry => "100x100#", :format => 'jpg', :time => 1}
			}, :processors => [:ffmpeg]

  def image_remote_url=(url_value)
  	self.image = URI.parse(url_value) unless url_value.blank?
  	super
  end

end
