class Relation < ActiveRecord::Base
  belongs_to :proposal
  belongs_to :experiencie
  belongs_to :user
  belongs_to :phase
  belongs_to :category

  attr_accessible :experiencie, :proposal, :user

  validates_presence_of :proposal_id, :experiencie_id, :user_id

  before_save :add_category_and_phase

  private
  def add_category_and_phase
    self.category_id = proposal.category_id
    self.phase_id = proposal.phase_id
  end
end
