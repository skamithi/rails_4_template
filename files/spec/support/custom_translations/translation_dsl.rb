require 'rspec/expectations'

RSpec::Matchers.define :have_an_english_translation do |expected|
  match do |actual|
    I18n.locale = 'en'
    string = I18n.t actual
    string !~ /translation missing/
  end
end
