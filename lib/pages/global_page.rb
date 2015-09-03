require 'csv'
require 'time'
require 'date'

class GlobalPage
  include PageObject
  include PageFactory
  include Navigation
  def get_last_created(dir)
    files = Dir.new(dir).select { |file| file!= '.' && file!='..' }
    return nil if (files.size < 1)
    files = files.collect { |file| dir+'/'+file }
    files = files.sort { |a,b| File.ctime(b)<=>File.ctime(a) }
    puts "name of the file is ....",files.first
    return File.open(files.first, "r")

  end
end