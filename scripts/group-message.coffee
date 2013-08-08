module.exports = (robot) ->
        
        robot.hear /@bristol/i, (msg) ->
          msg.replace /@bristol/i,  "@MD, @CD, @GG, @IP, @RB, @AF, @CS, @SM - " , (new) ->
                msg.send new
        robot.hear /@coventry/i, (msg) ->
          msg.replace /@coventry/i, "@SJ, @ST, @JW, @JF, @JS - " , (new) ->
                 msg.send new
