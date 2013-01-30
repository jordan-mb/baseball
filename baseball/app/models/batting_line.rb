class BattingLine < ActiveRecord::Base
  set_table_name(:batting)
  set_primary_keys(:playerID, :yearID, :stint)

  belongs_to :person
end