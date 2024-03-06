require_relative 'test_base'

class TestHelper < TestBase
  def setup
    @uri = Helper::URI_API_CRYPTOCURRENCIES
  end

  def test_generate_uri
    original_uri = "#{@uri}?id=1&range=1D"
    generate_uri = Helper.send(:generate_url, @uri, { id: 1, range: '1D' })

    assert_equal generate_uri, original_uri
  end
end
