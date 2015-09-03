class Idea < ActiveRecord::Base
  acts_as_votable
  acts_as_taggable

  belongs_to :user

  validates_presence_of :name, :description
end
