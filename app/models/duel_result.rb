class DuelResult < ApplicationRecord

    def self.ransackable_attributes(auth_object = nil)
      column_names
    end

    def self.ransackable_associations(auth_object = nil)
      Array(reflect_on_all_associations).map(&:name).map(&:to_s)
    end

	belongs_to :battle_info, :foreign_key => [:before_result_no, :left_party_no, :before_generate_no], :primary_key => [:result_no, :left_party_no, :generate_no], :class_name => "NextDuelInfo"
	belongs_to :left_party_info,  -> { where(party_type: 10)}, :foreign_key => [:result_no, :left_party_no, :generate_no], :primary_key => [:result_no, :party_no, :generate_no], :class_name => "PartyInfo"
	belongs_to :right_party_info, -> { where(party_type: 10)}, :foreign_key => [:result_no, :right_party_no, :generate_no], :primary_key => [:result_no, :party_no, :generate_no], :class_name => "PartyInfo"
	belongs_to :left_party_assault,  :foreign_key => [:before_result_no, :left_party_no,  :before_generate_no], :primary_key => [:result_no, :e_no, :generate_no], :class_name => "Assault"
	belongs_to :right_party_assault, :foreign_key => [:before_result_no, :right_party_no, :before_generate_no], :primary_key => [:result_no, :e_no, :generate_no], :class_name => "Assault"
end
