class Event < ActiveRecord::Base
  include IceCube
  
  validates :start_time, presence: true
  validates :title, presence: true
  validate :start_time_before_end_time

  belongs_to :user
  def start_time_before_end_time
    if self.start_time > self.end_time
      errors.add(:start_time, "Start time should be before end time")
    end
  end
  
  def schedule
      s = Schedule.new(start_time )
      s.add_recurrence_rule Rule.daily if self.rule == 'daily'
      s.add_recurrence_rule Rule.weekly if self.rule == 'weekly'
      s.add_recurrence_rule Rule.monthly if self.rule == 'monthly'
      s.add_recurrence_rule Rule.yearly if self.rule == 'yearly'
      s
  end

end
