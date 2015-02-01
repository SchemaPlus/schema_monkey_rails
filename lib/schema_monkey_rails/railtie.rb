module SchemaMonkey::Rails
  class Railtie < ::Rails::Railtie

    initializer 'schema_monkey.insert', :before => "active_record.initialize_database" do
      ActiveSupport.on_load(:active_record) do
        SchemaMonkey.insert
      end
    end

    rake_tasks do
      SchemaMonkey::Rake.insert('db:schema:dump', 'db:schema:load')
    end

  end
end
