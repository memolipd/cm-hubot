# Description:
#   Track arbitrary karma
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   <thing>++ - give thing some karma
#   <thing>-- - take away some of thing's karma
#   hubot karma <thing> - check thing's karma (if <thing> is omitted, show the top 5)
#   hubot karma empty <thing> - empty a thing's karma
#   hubot karma best - show the top 5
#   hubot karma worst - show the bottom 5
#   hubot karma doomsday countdown - Show how far off doomsday we are
#   hubot karma doomsday involve <thing> - Involve <thing> in the Doomsday reset
#   hubot karma doomsday reprieve <thing> - Remove <thing> from the Doomsday reset
#
# Author:
#   stuartf

class Karma

  constructor: (@robot) ->
    @cache = {}

    @karma_whitelist = {}

    @increment_responses = [
      "+1!", "gained a level!", "is on the rise!", "leveled up!"
    ]

    @decrement_responses = [
      "took a hit! Ouch.", "took a dive.", "lost a life.", "lost a level."
    ]

    @robot.brain.on 'loaded', =>
      if @robot.brain.data.karma
        @cache = @robot.brain.data.karma
      if @robot.brain.data.karma_whitelist
        @karma_whitelist = @robot.brain.data.karma_whitelist

  kill: (thing) ->
    delete @cache[thing]
    @robot.brain.data.karma = @cache

  increment: (thing) ->
    @cache[thing] ?= 0
    @cache[thing] += 1
    @robot.brain.data.karma = @cache

  decrement: (thing) ->
    @cache[thing] ?= 0
    @cache[thing] -= 1
    @robot.brain.data.karma = @cache

  incrementResponse: ->
     @increment_responses[Math.floor(Math.random() * @increment_responses.length)]

  decrementResponse: ->
     @decrement_responses[Math.floor(Math.random() * @decrement_responses.length)]

  get: (thing) ->
    k = if @cache[thing] then @cache[thing] else 0
    return k

  sort: ->
    s = []
    for key, val of @cache
      s.push({ name: key, karma: val })
    s.sort (a, b) -> b.karma - a.karma

  top: (n = 5) ->
    sorted = @sort()
    sorted.slice(0, n)

  bottom: (n = 5) ->
    sorted = @sort()
    sorted.slice(-n).reverse()
  
  # Evaluate the current state of the Karma to decide if a global reset should occur.
  potentialReset: (msg) ->
    available = @computeKarmaAvailable()
    allocated = @computeKarmaAllocated()
    if available != 0 and allocated >= available
      msg.send "The day of the great karma reset is upon us!"
      verbiage = ["Final karma for this time around was:"]
      s = []
      for key, v of @karma_whitelist
        s.push({ name: key, karma: @get key.toLowerCase() })
      s.sort (a, b) -> b.karma - a.karma
      for item, rank in s
        verbiage.push "#{rank + 1}. #{item.name} - #{item.karma}"
      msg.send verbiage.join("\n")
      # Reset all the karmas
      for key, v of @karma_whitelist
        @kill key.toLowerCase()
      msg.send "Those karmas have now been cleared"

  # Get the Karma per whitelisted object
  karmaPerObject: ->
    return process.env.KARMA_PER_OBJECT or 10

  # Compute the total global Karma available
  computeKarmaAvailable: ->
    return Object.keys(@karma_whitelist).length * @karmaPerObject()

  # Compute the total global Karma allocated
  computeKarmaAllocated: ->
    karmas = (@get thing.toLowerCase() for thing, v of @karma_whitelist)
    # Return the sum of all those looked up karmas.
    if karmas.length == 0
      return 0
    else
      return karmas.reduce (t, s) -> t + s

  whitelistObject: (thing) ->
    @karma_whitelist[thing] = 1
    @robot.brain.data.karma_whitelist = @karma_whitelist

  unWhitelistObject: (thing) ->
    delete @karma_whitelist[thing]
    @robot.brain.data.karma_whitelist = @karma_whitelist  

module.exports = (robot) ->
  karma = new Karma robot
  robot.hear /(\S+[^+\s])\+\+(\s|$)/, (msg) ->
    subject = msg.match[1].toLowerCase()
    karma.increment subject
    msg.send "#{subject} #{karma.incrementResponse()} (Karma: #{karma.get(subject)})"
    karma.potentialReset msg

  robot.hear /(\S+[^-\s])--(\s|$)/, (msg) ->
    subject = msg.match[1].toLowerCase()
    karma.decrement subject
    msg.send "#{subject} #{karma.decrementResponse()} (Karma: #{karma.get(subject)})"

  robot.respond /karma empty ?(\S+[^-\s])$/i, (msg) ->
    subject = msg.match[1].toLowerCase()
    karma.kill subject
    msg.send "#{subject} has had its karma scattered to the winds."

  robot.respond /karma( best)?$/i, (msg) ->
    verbiage = ["The Best"]
    for item, rank in karma.top()
      verbiage.push "#{rank + 1}. #{item.name} - #{item.karma}"
    msg.send verbiage.join("\n")

  robot.respond /karma worst$/i, (msg) ->
    verbiage = ["The Worst"]
    for item, rank in karma.bottom()
      verbiage.push "#{rank + 1}. #{item.name} - #{item.karma}"
    msg.send verbiage.join("\n")

  robot.respond /karma (best|top) (\d+)$/i, (msg) ->
    verbiage = ["The Best " + msg.match[2]]
    for item, rank in karma.top(msg.match[2])
      verbiage.push "#{rank + 1}. #{item.name} - #{item.karma}"
    msg.send verbiage.join("\n")

  robot.respond /karma (worst|bottom) (\d+)$/i, (msg) ->
    verbiage = ["The Worst " + msg.match[2]]
    for item, rank in karma.bottom(msg.match[2])
      verbiage.push "#{rank + 1}. #{item.name} - #{item.karma}"
    msg.send verbiage.join("\n")

  robot.respond /karma doomsday countdown$/i, (msg) ->
    available = karma.computeKarmaAvailable()
    allocated = karma.computeKarmaAllocated()
    msg.send "Currently there is #{allocated} karma out of a possible #{available} assigned."

  robot.respond /karma doomsday involve (\S+[^-\s])$/i, (msg) ->
    match = msg.match[1].toLowerCase()
    karma.unWhitelistObject match
    karma.whitelistObject match
    msg.send "Involved #{match} in the Doomsday event"
    verbiage = ["Those currently embroiled in it are:"]
    for item, v of karma.karma_whitelist
      verbiage.push "#{item}"
    msg.send verbiage.join("\n")

  robot.respond /karma doomsday reprieve (\S+[^-\s])$/i, (msg) ->
    match = msg.match[1].toLowerCase()
    karma.unWhitelistObject match
    msg.send "Reprieved #{match} from the Doomsday event"
    verbiage = ["Those currently embroiled in it are:"]
    for item, v of karma.karma_whitelist
      verbiage.push "#{item}"
    msg.send verbiage.join("\n")

  robot.respond /karma (\S+[^-\s])$/i, (msg) ->
    match = msg.match[1].toLowerCase()
    if match != "best" && match != "worst"
      msg.send "\"#{match}\" has #{karma.get(match)} karma."


