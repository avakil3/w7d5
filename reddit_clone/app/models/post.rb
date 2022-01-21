class Post < ApplicationRecord

	validates :title, presence:true

	belongs_to :author,
		primary_id: :id,
		foreign_key: :user_id,
		class_name: :User

	belongs_to :sub,
		primary_id: :id,
		foreign_key: :sub_id,
		class_name: :Sub
	
		# has_many :post_subs,
		# 	inverse_of: :posts

	
end
