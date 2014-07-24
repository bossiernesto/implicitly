class Class

  def types_of(sym, &block)
    #save old method first
    alias_method "__#{:sym.to_s}__", :sym

    puts sym
  end

end

class TypeChecker

  attr_accessor :method, :validators

  def initialize(method, &block)
    self.method = method
    self.instance_eval &block
  end

  def validators
    @validators || []
  end

  def param(param_sym, type)
    self.validators.push(TypeCheckerValidator.new(param_sym, type))
  end


end

class TypeCheckerValidator

  attr_accessor :param, :type

  def initialize(param, type)
    self.param = param
    self.type = type
  end

end