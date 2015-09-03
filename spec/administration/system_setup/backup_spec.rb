require './spec/spec_helper.rb'


describe "US6492-ENG: System Settings - Backup and Restore" do

  before :all do
    visit BackupPage
  end

  it "should be able to check Test Connection functionality - correct credentials::Tny1653608c" do
    on BackupPage do |page|
      page.enable_schedule
      page.Backup_validInputs
      expect_output='Connected Successfully'
      page.test_connection.should include expect_output
    end
  end

  it "should be able to check Test Connection functionality - incorrect credentials::Tny1653609c" do
    on BackupPage do |page|
      page.enable_schedule
      page.Backup_invalidInputs
      expect_output='Connection Failed'
      page.test_connection.should include expect_output
    end
  end

  it "should be able to check Scheduled backup with wrong credentials::Tny1653607c" do
    on BackupPage do |page|
      page.apply_button_element.click
      expect_output='The backup parameters are saved, but some are invalid/non-existing'
      page.warningmsg.should include expect_output
    end
  end

end

describe "US12920-ENG-UI while Backup is going on" do

  before :all do
    visit BackupPage
  end

  it "should be able to verify Back Up Page::Tny1672680c" do
    on BackupPage do |page|
      expect(page.chk_bkupPage).to be_true
    end
  end

  it "should be able to verify Back Up schedule fields disabled by default::Tny1844504c" do
    on BackupPage do |page|
      expect(page.schedule_disabled).to be_true
    end
  end

  it "should be able to verify Test Connection::Tny1672681c" do
    on BackupPage do |page|
      page.enable_schedule
      page.Backup_validInputs
      expect_output='Connected Successfully'
      page.test_connection.should include expect_output
    end
  end

  it "should be able to verify Back Up schedule with Apply ::Tny1672683c" do
    on BackupPage do |page|
      page.enable_schedule
      page.Backup_validInputs
      expect_output='Backup Scheduled Successfully'
      page.apply.should include expect_output
    end
  end

  it "should be able to verify Back Up schedule with Clear ::Tny1672682c" do
    on BackupPage do |page|
      page.enable_schedule
      page.Backup_validInputs
      expect(page.clear).to be_true
    end
  end

  it "should be able to verify Backup scheduled successfully' pop up window ::Tny1844501c" do
    on BackupPage do |page|
      page.enable_schedule
      page.Backup_validInputs
      expect_output='Backup Scheduled Successfully'
      page.apply.should include expect_output
    end
  end
end

describe "US12915-ENG: System Settings - Prime Insight CAR support with restore" do

  before :all do
    visit BackupPage
  end

  it "should be able to verify Back Up Page::Tny1726722c" do
    on BackupPage do |page|
      expect(page.chk_bkupPage).to be_true
    end
  end

  it "should be able to verify Test Connection::Tny1726723c" do
    on BackupPage do |page|
      page.enable_schedule
      page.Backup_validInputs
      expect_output='Connected Successfully'
      page.test_connection.should include expect_output
    end
  end

  it "should be able to verify Back Up Scheduled with Apply ::Tny1726725c" do
    on BackupPage do |page|
      page.enable_schedule
      page.Backup_validInputs
      expect_output='Backup Scheduled Successfully'
      page.apply.should include expect_output
    end
  end

  it "should be able to verify   Back Up Scheduled with clear ::Tny1726724c" do
    on BackupPage do |page|
      page.enable_schedule
      page.Backup_validInputs
      expect(page.clear).to be_true
    end
  end

end

describe "US18931-[Continued] Backup-Restore Include user preference data" do

  before :all do
    visit BackupPage
  end

  it "should be able to verify Back Up Page::Tny1855228c" do
    on BackupPage do |page|
      expect(page.chk_bkupPage).to be_true
    end
  end

  it "should be able to verify Test Connection::Tny1855229c" do
    on BackupPage do |page|
      page.enable_schedule
      page.Backup_validInputs
      expect_output='Connected Successfully'
      page.test_connection.should include expect_output
    end
  end

  it "should be able to verify Back Up Scheduled with Apply ::Tny1855232c" do
    on BackupPage do |page|
      page.enable_schedule
      page.Backup_validInputs
      expect_output='Backup Scheduled Successfully'
      page.apply.should include expect_output
    end
  end

  it "should be able to verify Back Up Scheduled with clear ::Tny1855230c" do
    on BackupPage do |page|
      page.enable_schedule
      page.Backup_validInputs
      expect(page.clear).to be_true
    end
  end

  it "should be able to verify with all Mandatory fields in page  ::Tny1855231c" do
    on BackupPage do |page|
      page.enable_schedule
      page.Backup_validInputs
      page.clear_button_element.click
      page.apply_button_element.click
      expect_output='SSH Backup Server is required field. Path is required field. Port is required field. Username is required field. Password is required field. Start Time is required field'
      page.warningmsg.should include expect_output
    end
  end

end


describe "ENG: System Settings - Backup and Restore" do

  before :all do
    visit BackupPage
  end

  it "should be able to verify Back Up Page::Tny1672680c" do
    on BackupPage do |page|
      expect(page.chk_bkupPage).to be_true
    end
  end

  it "should be able to verify Back Up schedule fields disabled by default::Tny1844504c" do
    on BackupPage do |page|
      expect(page.schedule_disabled).to be_true
    end
  end

  it "should be able to check Test Connection functionality - correct credentials::Tny1653608c" do
    on BackupPage do |page|
      page.enable_schedule
      page.Backup_validInputs
      expect_output='Connected Successfully'
      page.test_connection.should include expect_output
    end
  end

  it "should be able to check Test Connection functionality - incorrect credentials::Tny1653609c" do
    on BackupPage do |page|
      page.enable_schedule
      page.Backup_invalidInputs
      expect_output='Connection Failed'
      page.test_connection.should include expect_output
    end
  end

  it "should be able to check Scheduled backup with wrong credentials::Tny1653607c" do
    on BackupPage do |page|
      page.apply_button_element.flash.click
      expect_output='The backup parameters are saved, but some are invalid/non-existing'
      page.warningmsg.should include expect_output
    end
  end

  it "should be able to verify Back Up schedule with Apply ::Tny1672683c" do
    on BackupPage do |page|
      page.enable_schedule
      page.Backup_validInputs
      expect_output='Backup Scheduled Successfully'
      page.apply.should include expect_output
    end
  end

  it "should be able to verify Back Up schedule with Clear ::Tny1672682c" do
    on BackupPage do |page|
      page.enable_schedule
      page.Backup_validInputs
      expect(page.clear).to be_true
    end
  end

  it "should be able to verify with all Mandatory fields in page  ::Tny1855231c" do
    on BackupPage do |page|
      page.enable_schedule
      page.Backup_validInputs
      page.clear_button_element.flash.click
      page.apply_button_element.flash.click
      expect_output='SSH Backup Server is required field. Path is required field. Port is required field. Username is required field. Password is required field. Start Time is required field'
      page.warningmsg.should include expect_output
    end
  end

end