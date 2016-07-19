class Survey < ActiveRecord::Base
  has_many(:questions)
  validates(:name, {:presence => true})
  before_save(:format_name)

private

  define_method(:format_name) do
    self.name = (name().upcase())
  end
end
