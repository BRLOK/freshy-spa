class ApplicationRecord < ActiveRecord::Base

  self.abstract_class = true

  include Inputs::DateTimeParams

end
