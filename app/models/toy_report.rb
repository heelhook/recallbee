class ToyReport < ActiveRecord::Base
  belongs_to :toy

  serialize :remedy_types, Array
end
