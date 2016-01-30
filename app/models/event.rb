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
      case self.rule
      when 'daily'
        s.add_recurrence_rule Rule.daily
      when 'weekly'
        s.add_recurrence_rule Rule.weekly
      when 'monthly'
        s.add_recurrence_rule Rule.monthly
      when 'yearly'
        s.add_recurrence_rule Rule.yearly
      end
      s
  end

end
