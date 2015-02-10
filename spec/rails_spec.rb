require 'spec_helper'

module Client
  module ActiveRecord
    module Base
      def self.prepended(base)
        Client.inserted
      end
    end
  end

  def self.inserted
    @inserted = true
  end
  def self.inserted?
    @inserted
  end
  def self.reset
    @inserted = false
  end
end

describe SchemaMonkey::Rails do

  before(:all) do
    # minimial setup for a rails app
    Kernel.const_set "Dummy", Class.new(Rails::Application) { config.eager_load = true }
    ENV['DATABASE_URL'] = "#{SchemaDev::Rspec.db_configuration[:adapter]}://localhost/dummy"

    SchemaMonkey.register Client

    Rake.application = Rake::Application.new
    Rails.application.load_tasks
    Rails.application.initialize!
  end

  after(:each) do
    Client.reset
  end

  it "inserts client into app" do
    expect(Client).to be_inserted
  end

  it "inserts client into rake" do
    expect { Rake::Task["db:schema:dump"].invoke }.to raise_error(Errno::ENOENT)
    expect(Client).to be_inserted
  end

end
