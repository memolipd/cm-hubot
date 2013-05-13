# Description:
#   A simple script for hipchat mentions on multi-line messages.
#

module.exports = (robot) ->
  robot.hear /(@\w+) .*\n.*$/i, (msg) ->
    msg.send msg.match[1] + " see above"