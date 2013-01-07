class User < ActiveRecord::Base
  devise :database_authenticatable, :confirmable, :lockable, :recoverable,
    :registerable, :rememberable, :timeoutable, :token_authenticatable,
    :trackable, :validatable, :async

  def devise_mail_sent(method)
    method
  end

  def mail_options(notification)
    {}
  end
end
