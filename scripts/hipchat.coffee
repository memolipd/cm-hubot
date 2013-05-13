# Description:
#   A simple script for hipchat mentions on multi-line messages.
#

module.exports = (robot) ->
  # Listen for lines that have line breaks in them
  robot.hear /\n/i, (msg) ->
    # Now find all the mentions in that message.
    matches = msg.match[0].match /@\w+/g
    for match in matches
      do (handle) ->
        msg.send handle + " see above"
