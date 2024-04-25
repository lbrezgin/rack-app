require_relative 'time_formatter'
class App
  def call(env)
    req = Rack::Request.new(env)
    format = req.params["format"]

    if req.path_info == "/time" && format
      time_response = TimeFormatter.new(format)
      time_response.format_time
      if time_response.success?
        response(200, time_response.time_string)
      else
        response(400, "Unknown time format #{time_response.error_string}")
      end
    else
      response(404, "Error!\n")
    end
  end

  private

  def response(status, response_body)
    [
      status,
      { 'Content-Type' => 'text/plain' },
      [response_body]
    ]
  end
end







