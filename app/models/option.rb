class Option < ActiveRecord::Base
  attr_accessible :name, :asset_id
  belongs_to :asset
  EQUIPMENT_OPTIONS = ['Door Chain','Door Start','No Quick Start',
                      '2 Min Timer','Non-Water Saver','Tall Hood',
                      'Leg Extentions','VRX','Top-Mount','Quick Fill Kit',
                      'Pizza Conversion','Other','Pumped Drain']
  EQUIPMENT_MODELS = ['A4','A5','D2','D2 - Corner','AC-44','AC-66',
                      'ET','HT-25','U34','ASQ','U34-DD','UC-180',
                      'Dema 633','Dema 651','Dema 652','Dema 5in1',
                      'Bio-Flow','Other']
  ELECTRICAL_OPTIONS = ['','115v - Outlet','115v - Hard Wired','230v - Single Phase','230v - Three Phase', '480v']
  WATER_PLUMBING = ['','Copper','Galvanized','Pex']
  DRAIN_PLUMBING = ['','Direct-Copper','Direct-Cast Iron','Direct-PVC','Direct-ABS','Floor Sink']
end
