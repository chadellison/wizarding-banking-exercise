require 'minitest/autorun'
require_relative 'wizarding_bank'
require 'minitest/pride'
require 'pry'
class PersonTest < Minitest::Test
  def setup
    @jones = Person.new("Jones", 5000)
  end

  def test_it_is_a_person_object

    assert_equal Person, @jones.class
  end

  def test_it_takes_a_persons_name
    assert_equal "Jones", @jones.name
  end

  def test_it_has_money
    assert_equal 5000, @jones.amount
  end

  def test_it_can_print_a_statement
    submitted = "#{@jones.name} has been created with #{@jones.amount} galleons in cash."
    assert_equal submitted, @jones.statement
  end
end

class BankTest < Minitest::Test
  def setup
    @bank = Bank.new("JP Morgan Chase")
    @bank2 = Bank.new("Wells Fargo")
  end

  def test_it_is_a_bank_object
    assert_equal Bank, @bank.class
  end

  def test_it_has_a_name
    assert_equal "JP Morgan Chase", @bank.bank_name
    assert_equal "Wells Fargo", @bank2.bank_name
  end

  def test_it_can_print_a_bank_statement
    submitted = "#{@bank.bank_name} has been created"
    assert_equal submitted, @bank.bank_statement
  end

  def test_an_account_can_be_opened_for_a_person_with_a_print_statement
    @jones = Person.new("Jones", 5000)
    submitted = "An account has been opened for #{@jones.name} with #{@bank.bank_name}."
    assert_equal submitted, @bank.open_account(@jones.name)
  end

  def test_it_can_take_deposits
    assert @bank.respond_to?(:deposit)
  end

  def test_deposit_can_print_a_statement_with_person_and_amount
    minerva = Person.new("Minerva", 1000)

    submitted = "750 galleons have been deposited into Minerva's Chase account. Balance: 750 Cash: 250"

    assert_equal submitted, @bank.deposit(minerva, 750)
  end

  def test_a_person_cannot_deposit_more_than_they_have
    minerva = Person.new("Minerva", 1000)
    submitted = "Minerva does not have enough cash to perform this deposit."

    assert_equal submitted, @bank.deposit(minerva, 2000)
  end

  def test_a_bank_can_provide_withdrawal_to_a_person
    minerva = Person.new("Minerva", 500)
    @bank2.deposit(minerva, 500)
    submitted = "Minerva has withdrawn 250 galleons. Balance: 250"
    assert_equal submitted, @bank2.withdraw(minerva, 250)
  end

  def test_a_person_cannot_withdraw_more_than_existing_balance_amount
    minerva = Person.new("Minerva", 250)
    submitted = "Insufficient funds."
    assert_equal submitted, @bank.withdraw(minerva, 550)
  end
end
