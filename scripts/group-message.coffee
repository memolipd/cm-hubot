module.exports = (robot) ->
  robot.respond /bristoloffice? (.*)/i, (msg) ->
      msg.send "hello"
