class Person
  attr_reader :name
  attr_accessor :amount
  def initialize(name, amount)
    @name = name
    @amount = amount
  end

  def statement
    "#{name} has been created with #{amount} galleons in cash."
  end
end

class Bank
  attr_reader :bank_name, :balance

  def initialize(bank_name)
    @bank_name = bank_name
    @balance = 0
  end

  def bank_statement
    "#{bank_name} has been created"
  end

  def open_account(person)
    "An account has been opened for #{person} with #{bank_name}."
  end

  def deposit(person, deposit_amt)
    if person.amount < deposit_amt
      "#{person.name} does not have enough cash to perform this deposit."
    else
      @balance += deposit_amt
      person.amount -= deposit_amt
      "#{deposit_amt} galleons have been deposited into #{person.name}'s Chase account. Balance: #{balance} Cash: #{person.amount}"
    end
  end

  def withdraw(person, withdraw_amt)
    if @balance < withdraw_amt
      "Insufficient funds."
    else
      @balance -= withdraw_amt
      person.amount += withdraw_amt
      "#{person.name} has withdrawn #{withdraw_amt} galleons. Balance: #{balance}"
    end
  end
end
