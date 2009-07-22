module CountriesHelper

  def country_name(code)
    country = Country.find_by_iso(code) || Country.find_by_iso3(code) || Country.find_by_numcode(code) 
    if country
      country.name
    else
      code
    end
  end

end
