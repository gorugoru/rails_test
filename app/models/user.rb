class User
  include Mongoid::Document
  include Mongoid::Timestamps
  authenticates_with_sorcery!

  field :username, :type => String
  field :email, :type => String
  field :email_unconfirmed, :type => String
  field :activation_token, :type => String
  field :crypted_password, :type => String
  field :confirmation_token, :type => String
end
