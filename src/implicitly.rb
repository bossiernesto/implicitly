class Class

  def types_of(sym, &block)
    #save old method first
    old_method = "__#{sym.to_s}__".to_sym
    alias_method old_method, sym

    parameters = self.get_parameters_from_method sym
    #create a type checker and overwrite the original method with the new one
    type_checker = TypeChecker.new parameters, &block
    self.send :define_method, sym.to_sym do |*params|
      type_checker.validate_types(*params)
      self.send old_method.to_sym, *params
    end
  end

  def get_parameters_from_method(sym)
    unbound_method = self.instance_method(sym.to_sym)
    unbound_method.parameters.map { |p| p[1] }
  end

end

class TypeChecker

  attr_accessor :parameters, :validators

  def initialize(parameters, &block)
    self.parameters = parameters
    self.validators = []
    self.instance_eval &block
  end

  def param(param_sym, type)
    self.validators.push(TypeCheckerValidator.new(param_sym, type))
  end

  def validate_types(*params)
    zipped_params = self.parameters.zip(params)
    zipped_params.each do |param_name, param_value|
      validator=self.validators.select {|validator| validator.param == param_name}[0]
      validator.validate_value_type(param_value)
    end
  end

end

class TypeCheckerValidator

  attr_accessor :param, :type

  def initialize(param, type)
    self.param = param
    self.type = type
  end

  def validate_value_type(value)
    raise "TypeError: #{value} is not type of #{self.type}" unless value.class ==  self.type
  end

end