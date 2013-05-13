# Description:
#   A simple script for hipchat mentions on multi-line messages.
#

module.exports = (robot) ->
  # Listen for lines that have line breaks in them
  robot.hear /\n/im, (msg) ->
    # Now find all the mentions in that message.
    matches = msg.match.input.match /@\w+/gm
    if matches?
      for handle in matches
        msg.send handle + " see above"
