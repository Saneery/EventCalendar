require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Eventcalendar
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true
  end

  
end
module SimpleCalendar
  class MonthCalendar < SimpleCalendar::Calendar
    private

      def sorted_events
        events = options.fetch(:events, []).sort_by(&attribute)
        sorted = {}
        events.each do | event |
          cur = date_range.first - 1.day
          times = []
          while cur = event.schedule.next_occurrence(cur) and cur < date_range.last + 1.day 
            times.push cur
          end

          times.each do |time|
            date = time.to_date
            sorted[date] ||= []
            sorted[date] << event
          end
        end

        sorted
      end

  end
end
