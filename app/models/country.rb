class Country < ActiveRecord::Base

  def to_param
    iso
  end
end
