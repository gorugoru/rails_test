class Game
  include Mongoid::Document
  field :title, type: String
  field :description, type: String
  validates_presence_of :title, :message => 'タイトルを入力してください'
  validates_length_of :title, :minimum => 3, :message => '3文字以上をご入力ください'
end
