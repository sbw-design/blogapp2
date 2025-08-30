# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  # 記事が削除されるときに、関連する記事も削除する
  has_many :articles, dependent: :destroy
  # ユーザーが削除されるときに、関連するプロフィールも削除する
  has_one :profile, dependent: :destroy
  
  def has_written?(article)
    articles.exists?(id: article.id)
  end
  
  def display_name
    self.email.split('@').first
  end
end
