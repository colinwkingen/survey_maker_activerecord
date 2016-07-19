require('spec_helper')

describe(Question) do
  describe('#survey') do
    it "finds the survey assocated with a question" do
      survey1 = Survey.create({:name => "A survey"})
      question1 = Question.create({:name => 'whats up?', :survey_id => survey1.id})
      expect(question1.survey()).to(eq(survey1))
    end
  end
  describe('#answer') do
    it 'returns the answer of a specific question' do
      survey1 = Survey.create({:name => "A survey"})
      question1 = Question.create({:name => 'how are you feeling?', :survey_id => survey1.id, :answer => 'okay or whatever'})
      expect(question1.answer()).to(eq('okay or whatever'))
    end
  end
  describe('#done') do
    it 'returns a boolean that tells us if the question has been answered or not' do
      survey1 = Survey.create({:name => "A survey"})
      question1 = Question.create({:name => 'how are you feeling?', :survey_id => survey1.id, :answer => 'okay or whatever', :done => true})
      expect(question1.done()).to(eq(true))
    end
  end
end
