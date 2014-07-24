require 'rspec'
require_relative '../src/implicitly'

describe 'Test implicit infraestructure' do

  before(:each) do
    require_relative 'fixture_classes'

    implicit = Implicit.new
    implicit.for_class Canvas
    implicit.condition = lambda { |*params|
      params[0].is_a? Fixnum and params[1].is_a? Fixnum
    }
    implicit.conversion = lambda { |*params|
      Point.new(params[0], params[1])
    }

    Implicits.add implicit

  end

  after(:each) do

  end

end