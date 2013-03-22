# Description:
#   Hu will complete important song lyrics.
#

module.exports = (robot) ->
  robot.hear /^BUT$/, (msg) ->
    msg.send msg.random [
       "https://s3.amazonaws.com/ksr/projects/376855/photo-main.jpg?1352945926#.png"
      ,"https://si0.twimg.com/profile_images/2323541493/jnyln8ngz70b7skdj5ih.png#.png"
      ,"http://www.jobekia.com/data/logos/443/carre_but.jpg#.png"
      ,"http://www.blessedisthekingdom.com/wp-content/uploads/2013/02/but.jpg#.png",
      ,"http://www.theuniversalsolvent.net/wp-content/uploads/2011/05/Logo-BUT1.png#.png"
    ]
