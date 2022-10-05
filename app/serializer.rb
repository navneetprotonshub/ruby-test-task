class Serializer
  class << self
    attr_reader :elements

    def attribute(element, &block)
      @elements ||= {}
      @elements[element] = block
    end
  end

  attr_reader :object

  def initialize(object)
    @object = object
  end

  def serialize
    serialized_data = {}
    self.class.elements.each do |element, block|
      serialized_data[element] = object.send(element)
      serialized_data[element] = instance_eval(&block) unless block.nil?
    end
    serialized_data.compact
  end
end
