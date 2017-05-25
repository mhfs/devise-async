module TestHelpers
  def valid_attributes(attributes={})
    { username: "usertest",
      email: generate_unique_email,
      password: '12345678',
      password_confirmation: '12345678'
    }.update(attributes)
  end

  email_count = 0
  define_method :generate_unique_email do
    email_count += 1
    "test#{email_count}@example.com"
  end

  def create_admin(attributes={})
    Admin.create!(valid_attributes(attributes))
  end
end
