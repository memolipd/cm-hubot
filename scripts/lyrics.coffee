# Description:
#   Hu will complete important song lyrics.
#

module.exports = (robot) ->
  robot.hear /(^question(\?|\:)*$|[\,,\:,\?]+ question(\?|\:)*$)/i, (msg) ->
    msg.send "(music) Tell me what you think about this... (music)"
