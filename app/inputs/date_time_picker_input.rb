# Usage:
# = simple_form_for @user do |f|
#   = f.input :birthdate, as: :date_time_picker,\
#     input_html: { data: { date_end_date: I18n.l(Date.today), date_start_date: I18n.l(Date.new(1900)) } }
class DateTimePickerInput < SimpleForm::Inputs::DateTimeInput
  def input(wrapper_options)
    template.content_tag(:div) do
      template.concat div_datepicker
      template.concat div_timepicker
    end
  end

  private

  def div_datepicker
    template.content_tag(:div, datepicker_options) do
      template.concat span_calendar
      template.concat @builder.text_field(attribute_name, input_html_date_options)
    end
  end

  def div_timepicker
    template.content_tag(:div, timepicker_options) do
      template.concat span_clock
      template.concat @builder.text_field(attribute_name, input_html_time_options)
    end
  end

  def datepicker_options
    {
      class: 'input-group date datepicker col-xs-7',
      data: input_html_options[:data]
    }
  end

  def timepicker_options
    {
      class: 'input-group time col-xs-5',
      data: input_html_options[:data]
    }
  end

  def input_html_date_options
    custom_options = {
      id: date_input_id,
      name: date_input_name,
      class: 'form-control',
      readonly: true
    }
    custom_options[:value] = I18n.l(date_value) if date_value.present?
    input_html_options.merge(custom_options)
  end

  def input_html_time_options
    custom_options = {
      id: time_input_id,
      name: time_input_name,
      class: 'form-control timepicker',
      readonly: true
    }
    custom_options[:value] = time_value if time_value.present?
    input_html_options.merge(custom_options)
  end

  def date_value
    @builder.object.send(attribute_name).try(:to_date)
  end

  def time_value
    @builder.object.send(attribute_name).try(:to_s, :time)
  end

  def date_input_id
    "#{@builder.object_name}_#{attribute_name}_date"
  end

  def time_input_id
    "#{@builder.object_name}_#{attribute_name}_time"
  end

  def date_input_name
    "#{@builder.object_name}[#{attribute_name}][date]"
  end

  def time_input_name
    "#{@builder.object_name}[#{attribute_name}][time]"
  end

  def span_calendar
    template.content_tag(:span, class: 'input-group-addon') do
      template.concat icon_calendar
    end
  end

  def span_clock
    template.content_tag(:span, class: 'input-group-addon') do
      template.concat icon_clock
    end
  end

  def icon_calendar
    "<span class='glyphicon glyphicon-calendar'></span>".html_safe
  end

  def icon_clock
    "<span class='glyphicon glyphicon-time'></span>".html_safe
  end
end
