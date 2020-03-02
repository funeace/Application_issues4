class User < ApplicationRecord

  # ユーザ名が2文字〜20文字の制限(length)、空白じゃない(presence: true)
  validates :name, length: { in: 2..20 }, presence: true

  # 自己紹介文が最大50文字
  validates :introduction, length: {maximum: 50}

  #refileを使うときの設定。このモデルのattachmentがきたら、profile_image_id を見に行くってこと。多分
  attachment :profile_image

  #bookモデルと1:多の関係を作る（has_manyが1のほうで、 belongs_toが多のほう）
  has_many :books, dependent: :destroy

  # follow_followerを作る
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow

  has_many :reverse_relationships,class_name: 'Relationship',foreign_key: 'follow_id'
  has_many :followers, through: :reverse_relationships, source: :user
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def follow?(user)
    self.followings.include?(user)
  end

  def following(user)
    if self.follow?(user) == false
      self.relationships.new(follow_id: user.id).save
    end
  end

  def unfollow(user)
      self.relationships.find_by(follow_id: user.id).destroy
  end

end
