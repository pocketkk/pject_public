class Option < ActiveRecord::Base
  attr_accessible :name, :asset_id
  belongs_to :asset
  EQUIPMENT_OPTIONS = ['Door Chain','Door Start','No Quick Start',
                      '2 Min Timer','Non-Water Saver','Tall Hood',
                      'Leg Extentions','VRX','Top-Mount','Quick Fill Kit',
                      'Pizza Conversion','Pumped Drain', 'Extra-long Power Cord',
                      'Internal Scrap Box','External Scrap Box', 'Other']
  EQUIPMENT_MODELS = ['A4','A5','D2','D2C-R','D2C-L','AC-44','AC-66','AC Space-Maker',
                      'ET','HT-25','U34','ASQ','U34-DD','UC-180',
                      'Dema 633','Dema 651','Dema 652','Dema 5in1',
                      'Bio-Flow','Titan', 'Other']
  ELECTRICAL_OPTIONS = ['','115v - Outlet','115v - Hard Wired','230v - Single Phase','230v - Three Phase', '480v']
  WATER_PLUMBING = ['','Copper','Galvanized','Pex','3/8 Compression', '1/2 Compression']
  DRAIN_PLUMBING = ['','Direct-Copper','Direct-Cast Iron','Direct-PVC','Direct-ABS','Floor Sink']
end
