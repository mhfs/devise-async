class UserWithMailer < User

  def devise_mailer
    MyMailer
  end
end
