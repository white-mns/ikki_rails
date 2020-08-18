json.extract! skill_datum, :id, :skill_id, :name, :embryo_id, :is_physics, :lv, :sp, :gift_id, :gp, :created_at, :updated_at
json.url skill_datum_url(skill_datum, format: :json)
