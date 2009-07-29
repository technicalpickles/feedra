require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Feed do
  it { should validate_presence_of(:feed_url) }
  it { should have_many(:entries).dependent(:destroy) }
  it { should have_many(:feed_errors) }

  describe "normalize_feed_url" do
    it "should prepend http if feed_url is missing it" do
      feed = Feed.new(:feed_url => 'example.com/atom')

      feed.normalize_feed_url

      feed.feed_url_changed?.should be_true
      feed.feed_url.should == 'http://example.com/atom'
    end

    it "should not change if feed_url is nil" do
      feed = Feed.new(:feed_url => nil)

      feed.normalize_feed_url

      feed.feed_url.should == nil
    end

    it "should not change if feed_url is a empty string" do
      feed = Feed.new(:feed_url => "")

      feed.normalize_feed_url

      feed.feed_url.should == ""
    end
  end

end
