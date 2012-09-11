# Description:
#   Red button fail
#

module.exports = (robot) ->
  robot.hear /^exit$/i, (msg) ->
    msg.send "#bigredbuttonfail (facepalm)"
