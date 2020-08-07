require 'minitest/autorun'
require 'habakiri'

class HabakiriTest < Minitest::Unit::TestCase
  def test_case_1
    template = File.read('test/test_data/template_1.txt')
    text = File.read('test/test_data/text_1.txt')
    result = Habakiri.exec(template, text)

    assert_instance_of(Hash, result)
    assert_equal('テストテスト', result['name'])
    assert_equal('test.test@example.com', result['email'])
    assert_equal('01201234567', result['tel'])
    assert_equal('https://example.com/path/to/homepage/1232', result['url'])
    assert_equal('100-0001', result['zipcode'])
    assert_equal('東京都千代田区1-1-1', result['address'])
    assert_equal('東京駅', result['station'])
    assert_equal('メモメモ', result['memo1'])
    assert_equal('メモメモ2', result['memo2'])
    assert_equal('', result['blank'])
    assert_equal('備考備考', result['note'])
  end

  def test_case_2
    template = File.read('test/test_data/template_2.txt')
    text = File.read('test/test_data/text_2.txt')
    result = Habakiri.exec(template, text)

    assert_instance_of(Hash, result)
    assert_equal('12345678', result['no'])
    assert_equal('テストデータ', result['data_name'])
    assert_equal('12万3456円', result['cost'])
    assert_equal("いろはにほへとちりぬるをわかよたれそつねならむ\nういのおくやまけふこえてあさきゆめみしえひもせす", result['question'])
    assert_equal('テスト太郎', result['name'])
    assert_equal('てすとたろう', result['kana'])
    assert_equal('test.test@example.com', result['email'])
    assert_equal('090-0900-0900', result['tel'])
    assert_equal('女性', result['gender'])
  end

  def test_case_3
    template = File.read('test/test_data/template_3.txt')
    text = File.read('test/test_data/text_3.txt')
    result = Habakiri.exec(template, text)

    assert_instance_of(Hash, result)
    assert_equal('John', result['name'])
    assert_equal('email@email.com', result['email'])
    assert_equal('+199999999', result['tel'])
    assert_equal('https://example.com/website/url', result['url'])
    assert_equal('000-0000', result['zipcode'])
    assert_equal('San Francisco, CA 94107 United States', result['address'])
    assert_equal("Hello, world!\nHello, ruby!\nHello, habakiri!", result['note'])
  end

  def test_case_4
    template = File.read('test/test_data/template_4.txt')
    text = File.read('test/test_data/text_4.txt')
    result = Habakiri.exec(template, text)

    assert_instance_of(Hash, result)
    dup = result['dup']
    multi = result['multi']
    alone = result['alone']
    single = result['single']
    assert_instance_of(Array, dup)
    assert_instance_of(Array, multi)
    assert_equal(['テストテスト', 'test.test@example.com', '100-0001', '東京都千代田区1-1-1'], dup)
    assert_equal(['01201234567', 'https://example.com/path/to/homepage/1232', 'メモメモ', 'メモメモ2'], multi)
    assert_equal('東京駅', alone)
    assert_equal('備考備考', single)
  end
end
