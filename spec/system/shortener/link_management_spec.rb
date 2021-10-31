require 'rails_helper'

RSpec.describe 'Link Management', type: :system do
  let(:long_url) { 'https://google.com/any?with=query&string=values' }
  let(:link) { Shortener::Link.create(long_url: long_url) }

  it 'allows fill a full url at home page and create a shortened version' do
    visit '/'

    fill_in 'shortener_link_long_url', with: long_url
    click_button 'Shorten'

    link = Shortener::Link.last

    expect(page).to have_link(link.long_url)
    expect(page).to have_link(link.short_url)
  end

  context '404' do
    it 'renders 404 on invalid GET /:token' do
      visit '/abC123'

      expect(page).to have_http_status(404)
      expect(page).to have_text "The link you've clicked or entered is incorrect."
      expect(page).to have_link('home page')
    end

    it 'renders 404 on invalid GET /:token/info' do
      visit '/abC123/info'

      expect(page).to have_http_status(404)
      expect(page).to have_text "The link you've clicked or entered is incorrect."
      expect(page).to have_link('home page')
    end
  end

  context 'visit a token' do
    it 'track visitor data' do
      info_page_url = "#{link.short_url}/info"

      visit link.short_url

      last_visit = link.visitors.last
      expect(link.visitors.count).to eq(1)
      expect(last_visit.ip_address).to be_present
      expect(last_visit.referrer).to be_nil

      visit info_page_url
      click_link link.short_url

      last_visit = link.visitors.last
      expect(link.visitors.count).to eq(2)
      expect(last_visit.ip_address).to be_present
      expect(last_visit.session_id).to be_present
      expect(last_visit.referrer).to eq(info_page_url)
    end
  end
end
