require "rails_helper"

RSpec.describe 'Admin Rights User' do

  let!(:person){create(:person)}

  before do
    sign_in(person)
  end

  it "can access index" do
    get people_path
    expect(response).to be_successful
  end

  it "can add a new person" do
    get new_person_path
    expect(response).to be_successful
  end

  it "can add a property" do
    get new_property_path
    expect(response).to be_successful
  end

  it "can add a rent payment" do
    get new_rent_path
    expect(response).to be_successful
  end

  it "can add a calendar event" do
    get new_calendar_path
    expect(response).to be_successful
  end  

  it "can allocate a role" do
    get new_role_path
    expect(response).to be_successful
  end 

  it "can add a job" do
    get new_job_path
    expect(response).to be_successful
  end 

  it "can add a contractor" do
    get new_contractor_path
    expect(response).to be_successful
  end

  it "can add a maintenance record" do
    get new_maintenance_path
    expect(response).to be_successful
  end
  
  it "can add a worktype record" do
    get new_worktype_path
    expect(response).to be_successful
  end
end