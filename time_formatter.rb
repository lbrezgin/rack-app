class TimeFormatter

  attr_reader :formats, :format

  def initialize(format)
    @formats = {
      "year" => "%Y",
      "month" => "%m",
      "day" => "%d",
      "hour" => "%k",
      "minute" => "%M",
      "second" => "%S"
    }
    @format = format.split(",")
  end

  def time_format
    string = ""
    errors = []
    format.each do |form|
      if formats.keys.include?(form)
        string += formats[form] + "-"
      else
        errors.push(form)
      end
    end
    [errors, Time.now.strftime(string[0..-2])]
  end
end

