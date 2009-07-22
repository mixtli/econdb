class Country < ActiveRecord::Base
  belongs_to :map

  def to_param
    iso
  end
end
