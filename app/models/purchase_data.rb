class PurchaseData < ApplicationRecord
  def initialize(filename)
    fd = IO.open(filename)
    @io = IO.new(fd)
    @buffer = ""
  end

  def each(&block)
    @buffer << @io.sysread(512) until @buffer.include?($/)

    line, @buffer = @buffer.split($/, 2)

    block.call(line, @buffer)
    each(&block)
  rescue EOFError
    @io.close
  end

  def process_data(file)
    File.open('./base_teste.txt', 'r') do |f|
      f.each_line do |line|
      data << line.split
       end
      end

  end
end
