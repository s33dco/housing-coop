require "rails_helper"

RSpec.describe 'Rent Rights User' do

  let!(:person){create(:person, admin:false, rent_officer:true, maintenance:false, secretary:false)}

  before do
    sign_in(person)
  end

  it "can access index" do
    get people_path
    expect(response).to be_successful
  end

  it "cannot add a new person" do
    get new_person_path
    expect(response).not_to be_successful
  end

  it "can add a property" do
    get new_property_path
    expect(response).to be_successful
  end

  it "can add a rent payment" do
    get new_rent_path
    expect(response).to be_successful
  end

  it "cannot add a calendar event" do
    get new_calendar_path
    expect(response).not_to be_successful
  end  

  it "cannot allocate a role" do
    get new_role_path
    expect(response).not_to be_successful
  end 

  it "cannot add a job" do
    get new_job_path
    expect(response).not_to be_successful
  end 

  it "cannot add a contractor" do
    get new_contractor_path
    expect(response).not_to be_successful
  end

  it "cannot add a maintenance record" do
    get new_maintenance_path
    expect(response).not_to be_successful
  end

  it "cannot add a worktype record" do
    get new_worktype_path
    expect(response).not_to be_successful
  end
end