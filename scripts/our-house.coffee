# Description:
#   Example scripts for you to examine and try out.
#
# Notes:
#   These are from the scripting documentation: https://github.com/github/hubot/blob/master/docs/scripting.md

module.exports = (robot) ->

  robot.respond /commands/i, (res) ->
    res.reply 'set profile <string>\nfinger <username, without the @>\n8ball\nroll #d#\nroll dice\nflip a coin'

# Setters
  robot.respond /set profile (.*)/i, (res) ->
    description = res.match[1]
    res.reply 'Profile Set'
    robot.brain.set res.envelope.user.name + '_profile', description

# Getters
  robot.respond /finger (.*)/i, (res) ->
    name = res.match[1].trim()
    users = robot.brain.usersForFuzzyName(name)
    if users.length is 1
      user = users[0]
      res.send robot.brain.get user.name + '_profile'
      res.send robot.brain.get user.name + '_game'
    else
      res.send "I don't know about that person yet :neutral_face:"
