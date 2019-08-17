require 'rails_helper'

describe "cms admin" do
  it "can't view CMS admin if not signed in" do
    visit comfy_admin_cms_path
    expect(current_path).to eq root_path
    expect(page).to have_content "Please sign in as an admin user"
  end

  include_context 'signed in member' do
    it "can't view CMS admin if not an admin member" do
      visit comfy_admin_cms_path
      expect(current_path).to eq root_path
      expect(page).to have_content "Please sign in as an admin user"
    end
  end

  include_context 'signed in admin' do
    it "admin members can view CMS admin area" do
      visit comfy_admin_cms_path
      expect(current_path).to match(/#{comfy_admin_cms_path}/) # match any CMS admin page
    end
  end
end
