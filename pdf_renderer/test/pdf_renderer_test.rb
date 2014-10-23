require 'test_helper'

# Tests the general features of the PDF renderer.
class PdfRendererTest < ActiveSupport::TestCase
  test 'truth' do
    assert_kind_of Module, PdfRenderer
  end
end
