# Description:
#   Hu will complete important song lyrics.
#

module.exports = (robot) ->
  robot.hear /(^question(\?|\:)*$|[\,,\:,\?]+ question(\?|\:)*$)/i, (msg) ->
    msg.send "(music) Tell me what you think about this... (music)"

  robot.hear /^boom boom boom$/i, (msg) ->
    msg.send "(music) Even brighter than the moon, moon, moon! (music)"

  robot.hear /^no no no$/i, (msg) ->
    msg.send "(music) Don't funk with my heart (music)"
