# Description:
#   Assorted 'wrong window' responses
#

module.exports = (robot) ->
  # Big red button fail
  robot.hear /^exit$/i, (msg) ->
    msg.send "#bigredbuttonfail (facepalm)"

  # Git fails
  robot.hear /^git (st|status|diff|add|up|pull|push)$/i, (msg) ->
    msg.send "# On branch hipchat\n
nothing to commit (you're in the wrong window)"
    msg.reply "--"
