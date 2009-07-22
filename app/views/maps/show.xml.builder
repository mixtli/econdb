xml.map :borderColor => '005879', :fillColor => 'd7f4ff'  do
  xml.data do
    #xml.entity :id => 23, :value => 1000
    @countries.each do |id, country|
      xml.entity :id => Fusion.country_id_by_code(id), :value => country[:value], :link => CGI::escape(country_path(id))
    end 
  end
end
