module.exports = (robot) ->

        robot.respond /coventry/i, msg ->
                msg.send msg.replace /@coventry/i, "@SJ, @ST, @JW, @JF, @JS - "
                
        robot.respond /@bristol/i, msg ->
          msg.send msg.replace /@bristol/i,  "@MD, @CD, @GG, @IP, @RB, @AF, @CS, @SM - "
