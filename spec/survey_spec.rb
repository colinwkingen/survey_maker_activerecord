require('spec_helper')

describe(Survey) do
  describe('#questions') do
    it "returns the questions associated with this survey" do
      survey1 = Survey.create({:name => 'A Survey'})
      question1 = Question.create({:name => 'whats your name', :survey_id => survey1.id()})
      question2 = Question.create({:name => 'whats your favorite color', :survey_id => survey1.id()})
      expect(survey1.questions()).to(eq([question1, question2]))
    end
  end
  it "takes a survey title and caps it" do
    survey1 = Survey.create({:name => 'this is a lower case title'})
    expect(survey1.name()).to(eq("THIS IS A LOWER CASE TITLE"))
  end
end
