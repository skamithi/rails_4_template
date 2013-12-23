def bootstrap_test_frameworks
  # comment "# Configure app for testing (RSpec)"
  comment "# Configure app for testing (RSpec with Spork)"
  comment "# Bootstrap RSpec"
  generate 'rspec:install'
end

def configure_rspec
  comment 'install rspec'
  generate 'rspec:install'
  comment "# Replace generated spec_helper.rb with custom version"
  remove_file 'spec/spec_helper.rb'
  copy_from_repo 'spec/spec_helper.rb'
end

def customize_rspec
  comment '# customize rspec'
  copy_from_repo 'spec/support/capybara.rb'
  copy_from_repo 'spec/support/custom_translations/translation_dsl.rb'
  comment 'add spec category directories'
  %w{ model translations views controllers}.each do |i|
    empty_directory "spec/#{i}"
  end
end

def configure_factory_girl
  comment '# create directory where factory_girls files go'
  empty_directory 'spec/support/factories'
end

def configure_cucumber
  comment '#initialize cucumber'
  generate 'cucumber:install'
end

def customize_cucumber
  comment '# customize cucumber'
  copy_from_repo 'features/support/capybara.rb'
  copy_from_repo 'features/support/delorean.rb'
  copy_from_repo 'features/support/send_keys.rb'
  copy_from_repo 'features/support/factory_girl.rb'
  create_file 'features/step_definitions/common_steps.rb'
end

def customize_guard_file
  comment "# Edit generated default file so Guard doesn’t run all tests"
  comment "# after a failing test passes."
  gsub_file 'Guardfile',
            %r(guard 'rspec' do),
            "guard 'rspec', version: 2, all_after_pass: false, cli: '--drb' do"
  modernize_hash_syntax 'Guardfile'
end

def create_initial_specs
  comment "# Create home page routing spec"
  copy_from_repo 'spec/routing/routing_spec.rb'

  comment "# Create controller specs"
  copy_from_repo 'spec/controllers/application_controller_spec.rb'

  comment "# Create helper specs"
  copy_from_repo 'spec/helpers/application_helper_spec.rb'

  comment "# Create feature specs"
  copy_from_repo 'spec/features/layout_feature_spec.rb'
  copy_from_repo 'spec/features/pages_feature_spec.rb', erb: true
  copy_from_repo 'spec/features/user_authentication_feature_spec.rb'
  copy_from_repo 'spec/features/user_registration_feature_spec.rb'

  comment "# Create request specs"
  copy_from_repo 'spec/requests/authentication_requests_spec.rb'

  comment "# Create model specs"
  copy_from_repo 'spec/models/user_spec.rb'

  comment "# Create spec utilities"
  copy_from_repo 'spec/support/utilities.rb'
  copy_from_repo 'spec/support/custom_matchers.rb'

  comment "# Create shared contexts"
  copy_from_repo "spec/support/shared_contexts/"\
                 "shared_contexts_for_application.rb"
  copy_from_repo 'spec/support/shared_contexts/shared_contexts_for_layout.rb',
                 erb: true
  copy_from_repo 'spec/support/shared_contexts/shared_contexts_for_pages.rb',
                 erb: true
  copy_from_repo "spec/support/shared_contexts/"\
                 "shared_contexts_for_user_authentication.rb"
  copy_from_repo "spec/support/shared_contexts/"\
                 "shared_contexts_for_user_registration.rb"
end

def create_initial_factories
  comment "# Create users factory"
  copy_from_repo 'spec/factories/user_factories.rb'
end

def run_tests
  comment "# Run tests"
  run 'rspec spec/'
end

def configure_test_coverage
  comment "# Configure test coverage files"
  copy_from_repo '.simplecov'
  copy_from_repo '.coveralls.yml'
end
