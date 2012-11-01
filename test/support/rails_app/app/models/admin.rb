class Admin < ActiveRecord::Base
  devise :database_authenticatable, :confirmable, :lockable, :recoverable,
    :registerable, :rememberable, :timeoutable, :token_authenticatable,
    :trackable, :validatable, :async
end
