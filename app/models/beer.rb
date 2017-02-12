class Beer < ActiveRecord::Base
	belongs_to :brewery
  	has_many :ratings, dependent: :destroy
  	has_many :raters, through: :ratings, source: :user

	validates :name, presence: true
	validates :style, presence: true


	def average_rating 
		sum = 0
		ratings.each do |rating|
			sum = sum + rating.score
		end

		sum/ratings.count
	end

	def average
    	if ratings.count == 0
      		return 0
    	end
    	ratings.map{ |r| r.score }.sum / ratings.count.to_f
  	end

	def to_s
		"#{name} (#{brewery.name})"
	end

end
