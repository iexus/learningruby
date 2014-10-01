require_relative "../lib/birthday_notifier"
require "date"

describe BirthdayNotifier do

  describe "Congratulating old people" do
    
    it "will ask the repository for those who have a birthday on a given date" do
      mock_repository = double("repo")
      mock_email = double("email_service")
      a_date = Date.new(1900,1,1)

      bdayNote = BirthdayNotifier.new(mock_repository, mock_email)

      expect(mock_repository).to receive(:employees_with_birthdate).with(a_date) {[]}
      bdayNote.send_greetings(a_date)
    end


  end

end
