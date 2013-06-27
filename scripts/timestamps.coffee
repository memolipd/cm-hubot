# Description:
#   Allows Hubot to do timestamp conversions and date things.
#
# Commands:
#   hubot timestamp - Return the current UNIX timestamp in UTC.
#   hubot timestamp 1234567890 - Format the given UNIX timestamp as a UTC date string.
#   hubot day of the year - Return the current day of the year

sugar = require('sugar')

module.exports = (robot) ->
  robot.respond /timestamp( \d+)?/i, (msg) ->
    if msg.match[1]?
      # We need to convert the given timestamp to a human readable date.
      theDate = new Date(msg.match[1] * 1000)
      msg.send theDate.toGMTString()
    else
      # We need to just print the current timestamp in UTC.
      msg.send Math.round (new Date()).getTime() / 1000

  robot.respond /day of the year/i, (msg) ->
    now = new Date()
    onejan = new Date(now.getFullYear() , 0 , 1)
    msg.send "The current day is: " + Math.ceil((now - onejan) / 86400000);
