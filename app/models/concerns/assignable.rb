module Assignable
  extend ActiveSupport::Concern

  def add_branch(branch)
    self.branches.create!(branch_number: branch) unless already_assigned?(branch)
  end

  def remove_branch(branch)
    branches.each do |b|
      if b.branch_number == branch
        b.destroy
      end
    end
  end

  def already_assigned?(branch)
    unique=false
    branches.each do |b|
      if b.branch_number == branch
        unique=true
        break
      end
    end
    unique
  end

  def branches_to_a
    branches_array = []
    branches.each do |branch|
      branches_array << branch.branch_number
    end
    branches_array
  end

end
