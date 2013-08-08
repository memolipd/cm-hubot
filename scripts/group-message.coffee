module.exports = (robot) ->
        
    /*   robot.hear /@bristol/i, (msg) ->*/
      /*    msg.replace /@bristol/i,  "@MD, @CD, @GG, @IP, @RB, @AF, @CS, @SM - " , (new) ->*/
          robot.respond /@bristol/i, (msg) ->
                msg.send "@MD, @CD, @GG, @IP, @RB, @AF, @CS, @SM -"
                
                
        robot.hear /@coventry/i, (msg) ->
          msg.replace /@coventry/i, "@SJ, @ST, @JW, @JF, @JS - " , (new) ->
                 msg.send new
