class PurchaseData < ApplicationRecord
  require 'csv'

  NULL_STRING = 'NULL'.freeze

  # def initialize(filename)
  #   fd = IO.open(filename)
  #   @io = IO.new(fd)
  #   @buffer = ''
  # end

  # def each(&block)
  #   @buffer << @io.sysread(512) until @buffer.include?($/)

  #   line, @buffer = @buffer.split($/, 2)

  #   yield(line, @buffer)
  #   each(&block)
  # rescue EOFError
  #   @io.close
  # end

  # def process_data(_file)
  #   File.open('./base_teste.txt', 'r') do |f|
  #     f.each_line do |line|
  #       data << line.split
  #     end
  #   end
  # end

  def process_data
    ActiveRecord::Base.transaction do
      path = File.expand_path('base_teste.txt', File.dirname(__FILE__))
      result = []
      data_str = File.read(path)
      rows = CSV.new(data_str).each.to_a
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
        PurchaseData.create!(
          cpf: valid_cpf?(cpf.to_s),
          private_purchase: private_purchase,
          incomplete: incomplete,
          date_of_last_purchase: string_null?(date_of_last_purchase),
          average_ticket: string_null?(average_ticket),
          last_purchase_ticket: string_null?(last_purchase_ticket),
          most_frequent_store: valid_cnpj?(most_frequent_store.to_s),
          last_purchase_store: valid_cnpj?(last_purchase_store.to_s),
        )
      end
    end
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
      date_of_last_purchase: date_of_last_purchase.to_date,
      average_ticket: average_ticket,
      last_purchase_ticket: last_purchase_ticket,
      most_frequent_store: most_frequent_store.to_s,
      last_purchase_store: last_purchase_store.to_s,
    }
  end
end
