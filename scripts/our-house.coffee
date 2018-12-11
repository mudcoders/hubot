# Description:
#   Example scripts for you to examine and try out.
#
# Notes:
#   These are from the scripting documentation: https://github.com/github/hubot/blob/master/docs/scripting.md

module.exports = (robot) ->

  robot.respond /commands/i, (res) ->
    res.reply 'set profile <string>\nset game <string>\nfinger <username>\ngames'

# Setters
  robot.respond /set profile (.*)/i, (res) ->
    description = res.match[1]
    res.reply 'Profile Set'
    robot.brain.set res.envelope.user.name + '_profile', description

  robot.respond /set game (.*)/i, (res) ->
    description = res.match[1]
    res.reply 'Game Set'
    robot.brain.set res.envelope.user.name + '_game', description

# Getters
  robot.respond /finger (.*)/i, (res) ->
    name = res.match[1].trim()
    users = robot.brain.usersForFuzzyName(name)
    if users.length is 1
      user = users[0]
      res.send robot.brain.get user.name + '_profile'

  robot.respond /games/i, (res) ->
    name = res.match[1].trim()
    responseText = 'Games run by our users:'
    for user in robot.brain.users
      responseText += robot.brain.get user.name + '_game'
    res.send responseText
  
