require './spec/spec_helper.rb'

describe "US11466-Email Settings UI and integration" do

  before :all do
    visit EmailSettingsPage
  end

  it "should be able to check email setting page::Tny1695218c" do
    on EmailSettingsPage do |page|
      expect(page.chk_page).to be_true
    end
  end

  it "should be able to check save button::Tny1695220c" do
    on EmailSettingsPage do |page|
      expect(page.chk_save).to be_true
    end
  end

  it "should be able to check reset button::Tny1695221c" do
    on EmailSettingsPage do |page|
      expect(page.chk_reset).to be_true
    end
  end

  it "should be able to check delete button::Tny1695222c" do
    on EmailSettingsPage do |page|
      expect(page.chk_delete).to be_true
    end
  end

  it "should be able to check email settings default::Tny1695219c" do
    on EmailSettingsPage do |page|
      expect(page.chk_default).to be_true
    end
  end

  it "should be able to verify error msg upon sending mails without configuring SMTP server::Tny1695224c" do
    on EmailSettingsPage do |page|
      expect(page.chk_schedule_report).to be_true
    end
  end

end