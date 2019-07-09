class Wagon
  attr_accessor :type, :name

  def validate!
    raise "Carriage name couldn't be empty or nil" if @name.nil? || @name.empty?
  end

  def valid?
    validate!
  rescue
    false
  end
end
