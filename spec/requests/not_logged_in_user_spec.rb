require "rails_helper"

RSpec.describe 'A not logged in user' do

  it "can access welcome" do
    get root_path
    expect(response).to have_http_status(200)
  end

  it "can access allocations" do
    get allocations_path
    expect(response).to have_http_status(200)
  end

  it "can access contact" do
    get allocations_path
    expect(response).to have_http_status(200)
  end

  it "cannot access people index" do
    get people_path
    expect(response).to have_http_status(302)
  end

  it "cannot access calendar index" do
    get calendars_path
    expect(response).to have_http_status(302)
  end

  it "cannot access job index" do
    get jobs_path
    expect(response).to have_http_status(302)
  end

  it "cannot access maintenance index" do
    get maintenances_path
    expect(response).to have_http_status(302)
  end

  it "cannot access properties index" do
    get properties_path
    expect(response).to have_http_status(302)
  end

  it "cannot access rents index" do
    get rents_path
    expect(response).to have_http_status(302)
  end

  it "cannot access roles index" do
    get roles_path
    expect(response).to have_http_status(302)
  end

  it "cannot access worktypes index" do
    get worktypes_path
    expect(response).to have_http_status(302)
  end

  it "cannot add a new person" do
    get new_person_path
    expect(response).to have_http_status(302)
  end

  it "cannot add a property" do
    get new_property_path
    expect(response).to have_http_status(302)
  end

  it "cannot add a rent payment" do
    get new_rent_path
    expect(response).to have_http_status(302)
  end

  it "cannot add a calendar event" do
    get new_calendar_path
    expect(response).to have_http_status(302)
  end  

  it "cannot allocate a role" do
    get new_role_path
    expect(response).to have_http_status(302)
  end 

  it "cannot add a job" do
    get new_job_path
    expect(response).to have_http_status(302)
  end 

  it "cannot add a contractor" do
    get new_job_path
    expect(response).to have_http_status(302)
  end

  it "cannot add a maintenance record" do
    get new_maintenance_path
    expect(response).to have_http_status(302)
  end

  it "cannot add a worktype record" do
    get new_worktype_path
    expect(response).to have_http_status(302)
  end  
end
