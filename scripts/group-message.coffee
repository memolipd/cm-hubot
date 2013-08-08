module.exports = (robot) ->
        
          robot.respond /bristol/i, (msg) ->
                msg.send "@MD, @CD, @GG, @IP, @RB, @AF, @CS, @SM -"

