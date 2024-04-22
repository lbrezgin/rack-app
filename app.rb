class App

  def initialize
    @formats = {
      "year" => "%Y",
      "month" => "%m",
      "day" => "%d",
      "hour" => "%k",
      "minute" => "%M",
      "second" => "%S"
    }
  end

  def call(env)
    req = Rack::Request.new(env)
    format = req.params["format"]
    if req.path_info == "/time" && format
      new_format = format.split(",")
      if bad_format(new_format).empty?
        [
          200,
          { 'Content-Type' => 'text/plain' },
          [time_format(new_format)]
        ]
      else
        [
          400,
          { 'Content-Type' => 'text/plain' },
          ["Unknown time format #{bad_format(new_format)}"]
        ]
      end
    else
      [
        404,
        { 'Content-Type' => 'text/plain' },
        ["Error!\n"]
      ]
    end
  end

  private

  def bad_format(format)
    format.reject { |form| form if @formats.keys.include?(form) }
  end

  def time_format(format)
    string = ""
    format.each do |form|
      string += @formats[form] + "-"
    end
    Time.now.strftime(string[0..-2])
  end
end





