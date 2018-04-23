require "rails_helper"

RSpec.describe MessageMailer, type: :mailer do
  describe "contact" do
    let(:mail) { MessageMailer.contact }

    it "renders the headers" do
      expect(mail.subject).to eq("Contact")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
