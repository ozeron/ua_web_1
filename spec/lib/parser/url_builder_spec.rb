require 'spec_helper'

describe UrlBuilder do
  describe '#url' do
    let(:base_url) {'http://dou.ua'}
    context 'when url is valid' do
      it 'return url' do
        expect(UrlBuilder.url(base_url)).to eq(base_url)
      end
    end

    context 'when first url is nil' do
      it 'return base url' do
        expect(UrlBuilder.url(nil, base_url)).to eq(base_url)
      end
    end

    context 'when url is path' do
      it 'append it to base url' do
        expect(UrlBuilder.url('/',base_url)).to eq(base_url)
      end
    end

    context 'when absolute but no path' do
      it 'return base url' do
        expect(UrlBuilder.url('#',base_url)).to eq(base_url)
      end
    end

    context 'when hashbang first' do
      let(:url) { '#comments' }
      let(:result) { 'http://dou.ua#comments' }
      it 'return base url + hashbang and info' do
        expect(UrlBuilder.url('#comments',base_url)).to eq(result)
      end
    end

    context 'when schema is missing' do
      let(:url) {'jobs.dou.ua'}
      let(:result) { "http://#{url}"}
      it 'append schema from base url' do
        expect(UrlBuilder.url(url, base_url)).to eq(result)
      end
    end

  end
end