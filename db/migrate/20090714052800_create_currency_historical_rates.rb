class CreateCurrencyHistoricalRates < ActiveRecord::Migration
  def self.up
       create_table :currency_historical_rates do |t|
         t.column :created_on, :datetime, :null => false
         t.column :updated_on, :datetime
         
         t.column :c1,       :string,     :limit => 3, :null => false
         t.column :c2,       :string,     :limit => 3, :null => false
         
         t.column :source,   :string,     :limit => 32, :null => false
         
         t.column :rate,     :float,    :null => false
         
         t.column :rate_avg,      :float
         t.column :rate_samples,  :integer
         t.column :rate_lo,       :float
         t.column :rate_hi,       :float
         t.column :rate_date_0,   :float
         t.column :rate_date_1,   :float
         
         t.column :date,     :datetime, :null => false
         t.column :date_0,   :datetime
         t.column :date_1,   :datetime

         t.column :derived,  :string,   :limit => 64
       end
       
       add_index :currency_historical_rates, :c1
       add_index :currency_historical_rates, :c2
       add_index :currency_historical_rates, :source
       add_index :currency_historical_rates, :date
       add_index :currency_historical_rates, :date_0
       add_index :currency_historical_rates, :date_1
       add_index :currency_historical_rates, [:c1, :c2, :source, :date_0, :date_1], :name => 'c1_c2_src_date_range', :unique => true
  end

  def self.down
    drop_table :currency_historical_rates
  end
end
