require 'test_helper'

class DashboardsHelperTest < ActionView::TestCase
  include ERB::Util

  before do
    @date_1 = DateTime.new(2016, 5, 21).in_time_zone
    @date_2 = DateTime.new(2016, 5, 31).in_time_zone
    @monday_start = :monday
  end

  describe 'date_range method' do
    it 'should return correct default date range' do
      expected = 'May 16 - 22'
      assert_equal expected, date_range(date: @date_1)
    end

    it 'should return correct date range for Monthly' do
      c = Config.find_or_create_by(config_key: 'start_of_week')
      c.config_value = { options: ["Monthly"] }
      c.save!

      expected = 'May 1 - 31'
      assert_equal expected, date_range(date: @date_1)
    end
  end


  describe 'month_range method' do
    it 'should return correct date range when start and end months are same' do
      expected = 'May 1 - 31'
      assert_equal expected, month_range(date: @date_1)
    end
  end


  describe 'week_range method' do
    it 'should return correct date range when start and end months are same' do
      expected = 'May 16 - 22'
      assert_equal expected, week_range(date: @date_1)
    end

    it 'should return correct date range when start and end months differ' do
      expected = 'May 30 - June 5'
      assert_equal expected, week_range(date: @date_2)
    end
  end

  describe 'voicemail_options' do
    it 'should return an array based on patient voicemail_options' do
      Patient.voicemail_preference.values do |pref|
        refute_empty voicemail_options.select { |opt| opt[1] == pref }
      end
    end
  end

  describe 'remove_from_call_list_glyphicon' do
    it 'should return span tags' do
      assert_match /span/, remove_from_call_list_glyphicon
      assert_match /glyphicon-remove/, remove_from_call_list_glyphicon
      assert_match /Remove call/, remove_from_call_list_glyphicon
    end
  end

  describe 'call_glyphicon' do
    it 'should return span tags' do
      assert_match /span/, call_glyphicon
      assert_match /glyphicon-earphone/, call_glyphicon
      assert_match /Call/, call_glyphicon
    end
  end

end
