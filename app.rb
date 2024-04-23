require_relative 'time_formatter'
class App
  def call(env)
    req = Rack::Request.new(env)
    format = req.params["format"]

    if req.path_info == "/time" && format
      time_formatter = TimeFormatter.new(format)
      if time_formatter.time_format[0].empty?
        give_time(time_formatter)
      else
        format_error(time_formatter)
      end
    else
      request_error
    end
  end

  private

  def give_time(time_formatter)
    [
      200,
      { 'Content-Type' => 'text/plain' },
      [time_formatter.time_format[1]]
    ]
  end

  def format_error(time_formatter)
    [
      400,
      { 'Content-Type' => 'text/plain' },
      ["Unknown time format #{time_formatter.time_format[0]}"]
    ]
  end

  def request_error
    [
      404,
      { 'Content-Type' => 'text/plain' },
      ["Error!\n"]
    ]
  end
end






