# -*- coding: utf-8 -*-
require "active_record"
require "mysql2"

# Class Definitions
################################################################################
# ActiveRecord Employee
class Employee < ActiveRecord::Base
  validates_presence_of :name
  belongs_to :company
end

# ActiveRecord Company
class Company < ActiveRecord::Base
  validates_presence_of :name
  has_many :employees
end

# Main Routine
################################################################################
ActiveRecord::Base.establish_connection(
  adapter: "mysql2",
  host: "localhost",
  username: "XXXX",
  password: "XXXX",
  database: "ruby_sample_db"
);

aCompany = Company.where(:name => 'A-Company').first;

john = Employee.new;
john.name = "john";
john.company = aCompany;
john.save;

employees = Employee.where(:company_id => aCompany.id);

for employee in employees do
  p employee;
end

john.destroy;
