require 'rails_helper'

describe 'a job' do

		it "is valid with example attributes" do
			job = Job.new(job_attributes)
	    expect(job.valid?).to eq(true)
	  end 

  	it "rejects any weird charcters in Job titles" do
    names = %w[ <> !st3v3 @dav1d &*$<>]
	    names.each do |name|
	      person = Job.new(title: name)
	      person.valid?
	      
	      expect(person.errors[:title].any?).to eq(true)
	    end
	  end
end