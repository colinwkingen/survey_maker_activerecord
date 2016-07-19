require('sinatra')
require('sinatra/reloader')
require('sinatra/activerecord')
require('./lib/question')
require('./lib/survey')
also_reload('lib/**/*.rb')
require('pg')

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
  answer = params.fetch('question_answer')
  @question = Question.create({:name => name, :answer => answer, :survey_id => @survey.id })
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
