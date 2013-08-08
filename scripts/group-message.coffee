# Description:
#   Allows Hutbot to do 'group' notifications
#
# Commands:
#   hubot @bristol something or other
#   hubot @cov(entry) something or other

module.exports = (robot) ->
        
  robot.hear /@bristol/i, (msg) ->
    msg.send msg.message.text.replace /@bristol/ig,  "@MD, @CD, @GG, @IP, @RB, @AF, @CS, @SM"
  
  robot.hear /@cov(entry)?/i, (msg) ->
    msg.send msg.message.text.replace /@cov(entry)?/gi, "@SJ, @ST, @JW, @JF, @JS"

