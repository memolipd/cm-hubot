# Description:
#   Hu will complete important song lyrics.
#

module.exports = (robot) ->
  robot.hear /(^question(\?|\:)*$|[\,,\:,\?]+ question(\?|\:)*$)/i, (msg) ->
    msg.send "(music) Tell me what you think about this... (music)"

  robot.hear /^boom boom boom$/i, (msg) ->
    msg.send msg.random [
      "(music) Even brighter than the moon, moon, moon! (music)"
      "(music) I want you in my room, Let's spend the night together, From now until forever! (music)"
    ]

  robot.hear /^no no no$/i, (msg) ->
    msg.send msg.random [
      "(music) Don't funk with my heart (music)"
      "(music) You don't love me, this I know now (music)"
    ]
