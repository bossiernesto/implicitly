require 'rspec'
require_relative '../src/implicitly'
require_relative 'fixture_classes'

describe 'checking types for Ruby classes' do

  before(:each) do
    @canvas = Canvas.new
  end

  it 'incorrect type entered as parameters' do
    expect { @canvas.draw_point(34) }.to raise_exception
  end

  it 'correct type entered as parameters' do
    @canvas.draw_point(Point.new(30, 15)).should == 20
  end

  it 'incorrect type entered as parameters' do
    expect { @canvas.draw_circle(23, 45) }.to raise_exception
  end

  it 'incorrect second type parameters' do
    expect { @canvas.draw_circle(Point.new(1, 4), 'P') }.to raise_exception
  end

  it 'correct types entered as parameters' do
    @canvas.draw_circle(Point.new(24, 13), 34).should == 34
  end

end