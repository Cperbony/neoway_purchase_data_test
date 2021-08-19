class PurchaseData < ApplicationRecord
  require 'csv'

  NULL_STRING = 'NULL'.freeze

  def process_data
    start_at = Time.zone.now
    ActiveRecord::Base.transaction do
      path = File.expand_path('../../base_teste.txt', File.dirname(__FILE__))
      rows = CSV.new(File.read(path)).each.to_a
      rows -= rows.shift
      rows.last(10).map do |row|
        result = row.join(',').split
        cpf = result[0]
        private_purchase = result[1]
        incomplete = result[2]
        date_of_last_purchase = result[3]
        average_ticket = result[4]
        last_purchase_ticket = result[5]
        most_frequent_store = result[6]
        last_purchase_store = result[7]

        @data = PurchaseData.new(
           cpf: valid_cpf?(cpf.to_s),
           private_purchase: private_purchase,
           incomplete: incomplete,
           date_of_last_purchase: string_null?(date_of_last_purchase),
           average_ticket: string_null?(average_ticket),
           last_purchase_ticket: string_null?(last_purchase_ticket),
           most_frequent_store: valid_cnpj?(most_frequent_store.to_s),
           last_purchase_store: valid_cnpj?(last_purchase_store.to_s),
         )

        purchase_data = PurchaseData.find_by(cpf: @data[:cpf]) || nil

        if purchase_data.nil?

          @data.save
        else
          puts 'Registro já inserido!'
        end
      end
    end
    puts "\nDuration: #{seconds_to_time(Time.zone.now - start_at)}"
  end

  def seconds_to_time(seconds)
    Time.at(seconds.to_i).utc.strftime('%H:%M:%S')
  end

  def string_null?(attribute = nil)
    attribute == NULL_STRING ? nil : attribute
  end

  def valid_cpf?(data)
    CPF.valid?(data.to_s) ? data.to_s : 'Invalid CPF'
  end

  def valid_cnpj?(data)
    CNPJ.valid?(data.to_s) ? data.to_s : 'Invalid CPF'
  end

  def to_app
    {
      cpf: cpf,
      private_purchase: private_purchase,
      incomplete: incomplete,
      date_of_last_purchase: date_of_last_purchase,
      average_ticket: average_ticket,
      last_purchase_ticket: last_purchase_ticket,
      most_frequent_store: most_frequent_store.to_s,
      last_purchase_store: last_purchase_store.to_s,
    }
  end
end
