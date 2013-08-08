module.exports = (robot) ->
        
        robot.hear /@bristol/i, (msg) ->
          msg.send msg.replace /@bristol/i,  "@MD, @CD, @GG, @IP, @RB, @AF, @CS, @SM - "
        
        robot.hear /@coventry/i, (msg) ->
                msg.send msg.replace /@coventry/i, "@SJ, @ST, @JW, @JF, @JS - "
                
