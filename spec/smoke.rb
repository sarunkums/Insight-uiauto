require './spec/spec_helper.rb'

usecase_service = YAML::load(File.open("data/usecase_service.yml"))
interface_serv = usecase_service['common_attribute'][0]
interUtil_serv = usecase_service['interface_Utilization_service'][0]

describe "Smoke Tests" do
  
  context "in Home dashboards" do
    context "in Interface Utilization dashboard" do
  
      it "should have data populated in quickviews::Tny1682980c" do
        pending("Deferred") do
          sleep 10
          expect_output = interface_serv['interface_name']
          visit(InterfaceUtilization).interface_backplane(expect_output).should be_true
        end
      end
      
    end #in Interface Utilization dashboard
    
    context "in Errors and Discards dashboard" do
      it "should have data populated::Tny1682981c" do
        homepage = visit(HomePage)
        homepage.errors_and_discards_tab_element.click
        homepage.table_data_element.visible?
      end
    end #in Errors and Discards dashboard
    
    context "in QoS Classes dashboard" do
      it "should have data populated::Tny1682982c" do
        homepage = visit(HomePage)
        homepage.qos_classes_tab_element.click
        homepage.qos_classes_tab_element.visible?
      end
    end #in QoS Classes dashboard
  end #in Home dashboards
  
  context "in Menu Navigation" do
    
    context "in Report slideout menu" do
      
      it "should have a Custom Views link::Tny1682983c" do
        visit(CustomViewsPage).loaded?        
      end
      
      it "should have a Saved Reports link::Tny1682984c" do
        visit(SavedReportPage).loaded?
      end
      
      it "should have a Scheduled Reports link::Tny1682985c" do
        visit(ScheduledReportsPage).loaded?
      end
      
    end #in Report dropdown
    
    context "in Administration slideout menu" do
   
      it "should have a User Management link::Tny1682986c" do 
        visit(UsermanagementPage).loaded?
      end
      
       it "should have a Data Sources link::Tny1682989c" do
         visit(DataSourcesPage).loaded?
       end
             
       it "should have an Email Settings link::Tny1682990c" do
         visit(EmailSettingsPage).loaded?
       end
      
       it "should have a Log Configuration link::Tny1682991c" do
         visit(LogConfigurationPage).loaded?
       end
       
       it "should have a Backup link::Tny1682988c" do
         #pending("Response from Stefano") do
           visit(BackupPage).loaded?
         #end
       end
       
       it "should have a License Management link::Tny1682987c" do
         pending("License Management updates") do
           visit(LicenseManagementPage).loaded?
         end
       end
                
    end #in Administration slideout
    
  end #Menu Navigation
end #Smoke Tests