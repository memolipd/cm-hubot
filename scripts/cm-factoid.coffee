# Description:
#   A simple factoid script.
#
# Commands:
#   hubot <thing> is <factoid> - Remember a factoid about a thing.
#   <thing>? - Show an associated factoid for the thing.
#   hubot forget <thing> - Forget any factoid stored for the thing.

module.exports = (robot) ->

  robot.brain.data.cm_factoids ||= {}

  robot.respond /@?([\w -_]+) is (\<reply\>)?(.+)$/i, (msg) ->

    # Pop the matches into some useful variables.
    name = msg.match[1].trim()
    lookup_name = name.toLowerCase()
    isFullReply = if msg.match[2]? then true else false
    definition = msg.match[3].trim()

    if isFullReply
      response = definition
    else
      response = "#{name} is #{definition}"

    # Save this into the brain.
    robot.brain.data.cm_factoids[lookup_name] = response
    msg.send "Thanks, definition for #{name} stored."

  robot.respond /@? forget ([\w -_]+)$/i, (msg) ->
    name = msg.match[1].trim().toLowerCase()
    # Let's see if we have a matching factoid for this.
    if robot.brain.data.cm_factoids[name]?
      delete robot.brain.data.cm_factoids[name]
      msg.send "Okay, I've forgotten about #{name}"

  robot.hear /@?([\w -_]+)\?$/i, (msg) ->
    name = msg.match[1].trim().toLowerCase()
    # Let's see if we have a matching factoid for this.
    if robot.brain.data.cm_factoids[name]?
      msg.send robot.brain.data.cm_factoids[name]



