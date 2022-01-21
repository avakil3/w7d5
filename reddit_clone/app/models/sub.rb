class Sub < ApplicationRecord
    validates :title, presence: true

    belongs_to :moderator,
        primary_id: :id,
        foreign_key: :user_id,
        class_name: :User

	has_many :posts,
		primary_id: :id,
		foreign_key: :sub_id,
		class_name: :Post

    # has_many :posts,
	# 	inverse_of: :post_subs

end


#sub have many posts