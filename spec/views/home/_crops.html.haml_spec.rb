require 'rails_helper'

describe 'home/_crops.html.haml', type: "view" do
  before(:each) do
    # we need to set up an "interesting" crop
    @crop = FactoryBot.create(:crop)
    (1..3).each do
      @planting = FactoryBot.create(:planting, crop: @crop)
    end
    @photo = FactoryBot.create(:photo)
    (1..3).each do
      @crop.plantings.first.photos << @photo
    end
    render
  end

  it 'shows crops section' do
    assert_select 'h2', text: 'Some of our crops'
    assert_select "a[href='#{crop_path(@crop)}']"
  end

  it 'shows plantings section' do
    assert_select 'h2', text: 'Recently planted'
    rendered.should have_content @planting.location
  end

  it 'shows recently added crops' do
    assert_select 'h2', text: 'Recently planted'
  end

  it 'includes a link to all crops' do
    assert_select "a[href='#{crops_path}']", text: /View all crops/
  end
end
