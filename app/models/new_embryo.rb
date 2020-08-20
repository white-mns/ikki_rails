class NewEmbryo < ApplicationRecord
	belongs_to :embryo, :foreign_key => :embryo_id, :primary_key => :embryo_id, :class_name => "EmbryoName"
end
