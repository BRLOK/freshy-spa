## Usage:
##
## 1) Include module to model
## 2) Call accepts_date_time_params_for date_time_attributes
##
## Example:
##   include Inputs::DateTimeParams
##   accepts_date_time_params_for :start_at, :end_at

module Inputs::DateTimeParams
  extend ActiveSupport::Concern

  class_methods do
    def accepts_date_time_params_for(*attr_names)
      attr_names.each do |attribute|
        define_method("#{attribute}=") do |val|
          if val.is_a? Hash
            parsed_datetime = "#{val[:date]} #{val[:time]}".in_time_zone
            super(parsed_datetime)
          else
            super(val)
          end
        end
      end
    end
  end
end
