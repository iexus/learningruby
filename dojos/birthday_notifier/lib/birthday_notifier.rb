class BirthdayNotifier

  def initialize employee_repository, email_service
    @employee_repository = employee_repository
    @email_service = email_service
  end

  def send_greetings birth_date
    employees_with_birthday = @employee_repository.employees_with_birthdate birth_date

  end

end
