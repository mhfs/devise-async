class Admin < ActiveRecord::Base
  devise :database_authenticatable, :confirmable, :lockable, :recoverable,
    :registerable, :rememberable, :timeoutable,
    :trackable, :validatable, :async
end
