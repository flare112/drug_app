class Ingredient < ApplicationRecord
  has_many :drug_ingredients, dependent: :destroy, foreign_key: 'ingredient_id'
  has_many :drugs,through: :drug_ingredients

  validates :name, uniqueness: true, presence: true

  enum drive: { drive_ok: false, drive_ng: true }
  enum tobacco: { tobacco_ok: false, tobacco_ng: true }
  enum alcohol: { alcohol_ok: false, alcohol_ng: true }
end