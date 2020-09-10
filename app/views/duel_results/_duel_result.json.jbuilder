json.extract! duel_result, :id, :result_no, :generate_no, :before_result_no, :before_generate_no, :left_party_no, :right_party_no, :battle_result, :created_at, :updated_at
json.url duel_result_url(duel_result, format: :json)
