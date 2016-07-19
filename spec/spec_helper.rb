ENV['RACK_ENV'] = 'test'
require('rspec')
require('pg')
require('sinatra/activerecord')
require('question')
require('survey')
require('pry')

RSpec.configure do |config|
  config.after(:each) do
    Survey.all().each() do |this_survey|
      this_survey.destroy()
    end
    Question.all().each() do |this_question|
      this_question.destroy()
    end
  end
end
