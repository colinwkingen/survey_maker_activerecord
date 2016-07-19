require('sinatra')
require('sinatra/reloader')
require('sinatra/activerecord')
require('./lib/question')
require('./lib/survey')
also_reload('lib/**/*.rb')
require('pg')
require('pry')

get('/') do
  @surveys = Survey.all()
  erb(:index)
end

get('/surveys') do
  @surveys = Survey.all()
  erb(:index)
end

post('/surveys') do
  survey_name = params.fetch('survey_name')
  @new_survey = Survey.create({:name => survey_name})
  @surveys = Survey.all()
  erb(:index)
end

get('/surveys/:id') do
  @survey = Survey.find(params.fetch('id'))
  @questions = @survey.questions()
  erb(:edit_survey)
end

post('/questions/:id') do
  @survey = Survey.find(params.fetch('id'))
  name = params.fetch('question_name')
  @question = Question.create({:name => name, :survey_id => @survey.id })
  @questions = @survey.questions()
  erb(:edit_survey)
end

delete('/questions/:id') do
  @question = Question.find(params.fetch('id'))
  @survey = @question.survey()
  @question.destroy()
  @questions = @survey.questions()
  erb(:edit_survey)
end

delete('/surveys/:id') do
  @survey = Survey.find(params.fetch('id'))
  @survey.destroy()
  @surveys = Survey.all()
  erb(:index)
end

patch('/surveys/:id') do
  new_name = params.fetch('new_survey_name')
  @survey = Survey.find(params.fetch('id'))
  @survey.update({:name => new_name})
  @surveys = Survey.all()
  @questions = @survey.questions()
  erb(:edit_survey)
end

patch('/questions/:id') do
  new_text = params.fetch('new_question')
  @question = Question.find(params.fetch('id'))
  @question.update({:name => new_text})
  @survey = @question.survey()
  @questions = @survey.questions()
  erb(:edit_survey)
end

get('/surveys/:id/take') do
  @survey = Survey.find(params.fetch('id'))
  @questions = @survey.questions()
  erb(:survey)
end

get('/surveys/:id/results') do
  @survey = Survey.find(params.fetch('id'))
  erb(:result)
end

post('/surveys/:id/results') do
  @survey = Survey.find(params.fetch('id'))
  @survey.questions().each() do |question|
    answer = params.fetch('new_answer_' + question.id().to_s)
    question.update({:answer => answer})
  end
  erb(:result)
end
