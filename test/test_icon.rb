require_relative 'test_base'

class TestIcon < TestBase
  def setup
    @cryptocurrency = Coin.list(limit: 1, start: 1).first
    @original_uri = "https://s2.coinmarketcap.com/static/img/coins/64x64/#{@cryptocurrency.id}.png"
  end

  def test_generate_uri
    generate_uri = @cryptocurrency.get_icon(64)

    assert_equal generate_uri, @original_uri

    assert_raises ArgumentError do
      @cryptocurrency.get_icon(68)
    end
  end

  def test_exists_icon
    uri = URI(@cryptocurrency.get_icon(64))
    response = Net::HTTP.get_response(uri)

    assert response.is_a?(Net::HTTPOK)
  end
end
