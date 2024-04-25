class TimeFormatter

  attr_reader :formats, :format, :time_string, :error_string

  def initialize(format)
    @formats = {
      "year" => "%Y",
      "month" => "%m",
      "day" => "%d",
      "hour" => "%H",
      "minute" => "%M",
      "second" => "%S"
    }
    @format = format.split(",")
  end

  def success?
    error_string.empty?
  end

  def format_time
    string = ""
    errors = []
    format.each do |form|
      if formats.keys.include?(form)
        string += formats[form] + "-"
      else
        errors.push(form)
      end
    end
    @error_string = errors
    @time_string = Time.now.strftime(string[0..-2]) if error_string.empty?
  end
end

