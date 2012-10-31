# -*- coding: utf-8 -*-
require 'test_helper'

class JpSampleMailerTest < ActionMailer::TestCase

  test "deliver" do
    JpSampleMailer.simple_test.deliver
  end

end

