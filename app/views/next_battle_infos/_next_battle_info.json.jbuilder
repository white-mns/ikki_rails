json.extract! next_battle_info, :id, :result_no, :generate_no, :party_no, :is_boss, :enemy_party_name_id, :member_num, :enemy_names, :created_at, :updated_at
json.url next_battle_info_url(next_battle_info, format: :json)
