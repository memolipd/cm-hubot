# Description:
#   Hu will be a little more human, and witty
#

module.exports = (robot) ->
  robot.hear /^BUT$/, (msg) ->
    msg.send msg.random [
      "https://s3.amazonaws.com/ksr/projects/376855/photo-main.jpg?1352945926#.png"
      "https://si0.twimg.com/profile_images/2323541493/jnyln8ngz70b7skdj5ih.png#.png"
      "http://www.jobekia.com/data/logos/443/carre_but.jpg#.png"
      "http://www.blessedisthekingdom.com/wp-content/uploads/2013/02/but.jpg#.png",
      "http://www.theuniversalsolvent.net/wp-content/uploads/2011/05/Logo-BUT1.png#.png"
    ]
  robot.hear /^BRB$/, (msg) ->
    msg.send msg.random [
      "http://mediacdn.snorgcontent.com/media/catalog/product/b/r/brb_fullpic_artwork_1.jpg#.png"
      "http://mctoastface.files.wordpress.com/2010/01/brb.jpg#.png"
      "http://2.bp.blogspot.com/-9P1mj8KsjYQ/Te3AWMFR3AI/AAAAAAAAAdw/tgvw3Xws4_I/s400/brb1.jpg#.png"
    ]
