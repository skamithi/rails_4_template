require 'capybara/rspec'

#Enable poltergeist. headless web browser
#require 'capybara/poltergeist'
#Capybara.javascript_driver = :poltergeist

# Using chrome as browser to test in capybara.
Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

def show_page(str)
  path ||= "capybara-#{Time.new.strftime("%Y%m%d%H%M%S")}#{rand(10**10)}.html"
  path = File.expand_path(path, Capybara.save_and_open_page_path) if Capybara.save_and_open_page_path

  FileUtils.mkdir_p(File.dirname(path))

  File.open(path,'w') { |f| f.write(str) }
  Launchy.open(path)
end
