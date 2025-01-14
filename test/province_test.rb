gem 'minitest', '~> 5.4'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/province'
require_relative '../lib/data'

class ProvinceTest < Minitest::Test
  extend Minitest::Spec::DSL

  let(:asia) { Province.new(sample_province_data) }
  let(:no_producers) { Province.new(sample_province_no_producers) }
  let(:string_for_producers) { Province.new(sample_province_string_producers) }

  def test_province_shortfall
    assert_equal(5, asia.shortfall)
  end

  def test_province_no_producers_shortfall
    assert_equal(30, no_producers.shortfall)
  end

  def test_province_profit
    assert_equal(230, asia.profit)
  end

  def test_province_no_producers_profit
    assert_equal(0, no_producers.profit)
  end

  def test_province_production_change
    asia.producers[0].production = 20
    assert_equal(-6, asia.shortfall)
    assert_equal(292, asia.profit)
  end

  def test_province_zero_demand
    asia.demand = 0
    assert_equal(-25, asia.shortfall)
    assert_equal(0, asia.profit)
  end

  def test_province_negative_demand
    asia.demand = -1
    assert_equal(-26, asia.shortfall)
    assert_equal(-10, asia.profit)
  end

  def test_province_empty_string_demand
    asia.demand = ""
    no_method_error_output_shortfall = "\# encoding: US-ASCII\n" + "\#    valid: true\n" + "undefined method `-' for \"\":String\n" + "Did you mean?  -@"
    error = assert_raises(NoMethodError) do 
      asia.shortfall
    end
    no_method_error_output_profit = "\# encoding: US-ASCII\n" + "\#    valid: true\n" + "undefined method `-' for \"\":String\n" + "Did you mean?  -@"
    error = assert_raises(NoMethodError) do 
      asia.shortfall
    end
    # assert_equal(no_method_error_output_shortfall, error.message)
    # assert_equal(no_method_error_output_profit, error.message)
  end

  # Producers cannot accomodate a string
  # def test_province_string_for_producers
  #   assert_equal(0, string_for_producers.shortfall)
  # end  
end
