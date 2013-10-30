# Description:
#   A simple factoid script.
#
# Commands:
#   hubot '<thing>' is <factoid> - Remember a factoid about a thing.
#   hubot '<otherthing>' aliases '<thing>' - Recall the 'thing' factoid when asking about 'otherthing'.
#   <thing>? - Show an associated factoid for the thing.
#   hubot forget '<thing>' - Forget any factoid stored for the thing.
#   hubot factoids - Displays all factoids and aliases.
#   hubot factoids <query> - Displays all factoids and aliases that match <query>.

module.exports = (robot) ->

  robot.brain.data.cm_factoids ||= {}
  robot.brain.data.cm_factoids_aliases ||= {}


  # Handle listening for new factoids.
  robot.respond /@?(['"])([^\1]+?)\1 is (\<reply\>)?([\s\S]+)$/i, (msg) ->

    # Pop the matches into some useful variables.
    name = msg.match[2].trim()
    lookup_name = name.toLowerCase()
    isFullReply = if msg.match[3]? then true else false
    definition = msg.match[4].trim()

    if isFullReply
      response = definition
    else
      response = "#{name} is #{definition}"

    # Save this into the brain.
    robot.brain.data.cm_factoids[lookup_name] = response
    msg.send "Thanks, definition for #{name} stored."

  # Handle listening for new aliases for factoids.
  robot.respond /@?(['"])([^\1]+?)\1 aliases (['"])([^\3]+?)\3$/i, (msg) ->
    alias = msg.match[2].trim()
    alias_lookup = alias.toLowerCase()
    name = msg.match[4].trim()
    lookup_name = name.toLowerCase()
    if robot.brain.data.cm_factoids[lookup_name]?
      robot.brain.data.cm_factoids_aliases[alias] = lookup_name
      msg.send "Thanks, #{name} can now be reached via #{alias} too."

  # Handle removing factoids.
  robot.respond /@?forget (['"])([^\1]+?)\1$/i, (msg) ->
    name = msg.match[2].trim().toLowerCase()
    # Let's see if we have a matching factoid for this.
    if robot.brain.data.cm_factoids[name]?
      delete robot.brain.data.cm_factoids[name]
      msg.send "Okay, I've forgotten about #{name}"
    # Let's see if it matches in the aliases.
    else if robot.brain.data.cm_factoids_aliases[name]?
      delete robot.brain.data.cm_factoids_aliases[name]
      msg.send "Okay, I've forgotten about the alias #{name}"

  # Handle listening for factoids.
  robot.hear /@?\?$/i, (msg) ->
    name = msg.message.text.slice(0, -1).toLowerCase()
    # Let's see if we have a matching factoid for this.
    if robot.brain.data.cm_factoids[name]?
      msg.send robot.brain.data.cm_factoids[name]
    # If we don't maybe we have an alias.
    else if robot.brain.data.cm_factoids_aliases[name]?
      aliased_name = robot.brain.data.cm_factoids_aliases[name]
      if robot.brain.data.cm_factoids[aliased_name]?
        msg.send "#{name} is aliased to #{aliased_name}, let me look that up..."
        msg.send robot.brain.data.cm_factoids[aliased_name]


  # Handle search for factoids.
  robot.respond /factoids\s*(.*)?$/i, (msg) ->
    factoids = Object.keys(robot.brain.data.cm_factoids).sort()
    factoids_aliases = Object.keys(robot.brain.data.cm_factoids_aliases).sort()
    search_strings = factoids.concat(factoids_aliases)
    filter = msg.match[1]

    if filter
      search_strings = search_strings.filter (fact) ->
        fact.match new RegExp(filter, 'i')
      if search_strings.length == 0
        msg.send "No factoids match #{filter}"
        return

    msg.send search_strings.join "\n"
