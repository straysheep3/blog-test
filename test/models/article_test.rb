require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  # 空の値のチェック
  test "presence" do
    article = Article.new
    assert article.invalid?
    assert article.errors.include?(:title)
    assert article.errors.include?(:body)
    assert article.errors.include?(:released_at)
  end
  # 長さのチェック
  test "length" do
    article = FactoryGirl.build(:article)
    article.title = "A" * 201
    assert article.invalid?
    assert article.errors.include?(:title)
  end
  # 掲載終了日時は掲載開始日時より後
  test "expired_at" do
    article = FactoryGirl.build(:article)
    article.released_at = Time.current
    article.expired_at = 1.days.ago
    assert article.invalid?
    assert article.errors.include?(:expired_at)
  end
end
