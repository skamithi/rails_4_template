def create_basic_initializers_for_installed_gems
#  comment "# Create Better Errors initializer file"
#  comment "# with support for Sublime Text 2"
#  copy_from_repo 'config/initializers/better_errors.rb'
#
#  comment "# Create Bullet initializer file"
#  copy_from_repo 'config/initializers/bullet.rb'
#
#  comment "# Create i18n initializer file"
#  copy_from_repo 'config/initializers/i18n.rb'
#
#  comment "# Create Rails Footnotes initializer file"
#  comment "# with monkey patch for HAML views,"
#  comment "# and support for Sublime Text 2"
#  copy_from_repo 'config/initializers/rails_footnotes.rb'
end

#def insert_figaro_config_into_secret_token
#  comment "# Edit secret token initializer file to reference"
#  comment "# ENV value set in Figaro config"
#  insert_into_file 'config/initializers/secret_token.rb',
#                   before: %r(#{app_name.camelize}) do <<-RUBY
#if Rails.env.production? && ENV['SECRET_KEY_BASE'].blank?
#  raise 'SECRET_KEY_BASE environment variable must be set!'
#end
#
#RUBY
#  end
#  gsub_file 'config/initializers/secret_token.rb', %r(\=.+),
#    "= ENV['SECRET_KEY_BASE'] || ('x' * 30)"
#end

def active_record_fixes
  comment "nullify active record blank attributes"
  copy_from_repo 'config/initializers/active_record_fixes.rb'
end

def form_field_defaults
  comment "Define form field defaults"
  copy_from_repo 'config/initializers/form_field_defaults.rb'
end

def simple_form_initializer
  comment "# Create simple_form initializer file,"
  comment "# change its hashes to modern syntax, and remove extraneous "
          "blank lines"
  generate 'simple_form:install'
  modernize_hash_syntax 'config/initializers/simple_form.rb'
  gsub_file 'config/initializers/simple_form.rb',
            %r(development\?\nend\n)
            "development\?\nend"
end

def i18n_js_initializer
  comment "Initialize i18n-js"
  rake 'i18n:js:setup'
end

def high_voltage_initializer
  comment "Initialize high voltage static page provider"
  copy_from_repo "config/initializers/high_voltage.rb"
end
