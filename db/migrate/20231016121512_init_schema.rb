class InitSchema < ActiveRecord::Migration[5.0]
  def up
    create_table "drug_ingredients", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci" do |t|
      t.bigint "drug_id"
      t.bigint "ingredient_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["drug_id", "ingredient_id"], name: "index_drug_ingredients_on_drug_id_and_ingredient_id", unique: true
      t.index ["drug_id"], name: "index_drug_ingredients_on_drug_id"
      t.index ["ingredient_id"], name: "index_drug_ingredients_on_ingredient_id"
    end
    create_table "drug_symptoms", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci" do |t|
      t.bigint "drug_id"
      t.bigint "symptom_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["drug_id", "symptom_id"], name: "index_drug_symptoms_on_drug_id_and_symptom_id", unique: true
      t.index ["drug_id"], name: "index_drug_symptoms_on_drug_id"
      t.index ["symptom_id"], name: "index_drug_symptoms_on_symptom_id"
    end
    create_table "drugs", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci" do |t|
      t.string "name", null: false, comment: "商品名"
      t.string "effect_text", comment: " 効能効果"
      t.string "usage", comment: "用法用量"
      t.string "document_url", comment: "添付文書URL"
      t.string "formulation", comment: "剤型 -- tablet(錠剤): 0, powder(粉): 1, capsule(カプセル): 2, liquid(液剤): 3, nose(点鼻): 4"
      t.string "division", comment: "リスク区分 -- to_guide(要指導医薬品): 0, one_kind(一類医薬品): 1, two_kind(二類医薬品): 2, three_kind(三類医薬品): 3, two_designate(指定二類医薬品): 4"
      t.string "taxation", default: "0", null: false, comment: "セルフメディケーション税制"
      t.integer "for_days", comment: "何日ぶん"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.text "formula", comment: "成分分量"
      t.text "otc_text", comment: "製品の特徴"
      t.text "caution", comment: "使用上の注意"
      t.bigint "maker_name_id"
      t.index ["maker_name_id"], name: "index_drugs_on_maker_name_id"
    end
    create_table "ingredients", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci" do |t|
      t.string "name", null: false
      t.string "drive", default: "0", null: false
      t.string "tobacco", default: "0", null: false
      t.string "alcohol", default: "0", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
    create_table "likes", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci" do |t|
      t.bigint "user_id", null: false
      t.bigint "drug_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["drug_id"], name: "index_likes_on_drug_id"
      t.index ["user_id"], name: "index_likes_on_user_id"
    end
    create_table "maker_names", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci" do |t|
      t.string "name", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
    create_table "symptoms", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci" do |t|
      t.string "name", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
    create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci" do |t|
      t.string "email", null: false
      t.string "crypted_password"
      t.string "salt"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string "username"
      t.boolean "admin", default: false
      t.index ["email"], name: "index_users_on_email", unique: true
    end
    add_foreign_key "drug_ingredients", "drugs"
    add_foreign_key "drug_ingredients", "ingredients"
    add_foreign_key "drug_symptoms", "drugs"
    add_foreign_key "drug_symptoms", "symptoms"
    add_foreign_key "drugs", "maker_names"
    add_foreign_key "likes", "drugs"
    add_foreign_key "likes", "users"
  end

  def down
    raise ActiveRecord::IrreversibleMigration, "The initial migration is not revertable"
  end
end