# Description:
#   Allows Hubot to do timestamp conversions.
#
# Commands:
#   hubot timestamp - Return the current UNIX timestamp in UTC.
#   hubot timestamp 1234567890 - Format the given UNIX timestamp as a UTC date string.
module.exports = (robot) ->
  robot.respond /timestamp( \d+)?/i, (msg) ->
    if msg.match[1]?
      # We need to convert the given timestamp to a human readable date.
      theDate = new Date(msg.match[1] * 1000)
      msg.send theDate.toGMTString()
    else
      # We need to just print the current timestamp in UTC.
      msg.send Math.round (new Date()).getTime() / 1000
