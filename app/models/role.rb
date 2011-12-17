class Role < ActiveRecord::Base
	has_one :role_user
end
