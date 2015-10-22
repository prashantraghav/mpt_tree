module Tree
  class TreeGenerator < Rails::Generators::NamedBase
    source_root File.expand_path('../templates', __FILE__)

    def create_initializer
      copy_file  "init.rb", init_file unless File.file? init_file
    end

    def migration
      args.unshift('title:string')
      @args = args
      Rails::Generators.invoke('model', [file_name, args, '-s'], {:behavior=>behavior})
    end

    def add_acts_as_tree_to_model
      if behavior.to_s == "invoke"
        inject_into_file "app/models/#{file_name}.rb", :after=>"ActiveRecord::Base\n" do <<-'TREE'
        acts_as_tree
        TREE
        end
      end
    end

    def controller_template
     template "controller.rb", "app/controllers/#{file_name.pluralize}_controller.rb"
    end

    def add_resources_to_routes
      if behavior.to_s == "invoke"
        inject_into_file "config/routes.rb", :after=>"Rails.application.routes.draw do\n" do "
          resources :#{file_name.pluralize}
          "
        end
      end
    end

    private 
    def init_file
      "config/initializers/mpt_tree.rb"
    end

  end
end
