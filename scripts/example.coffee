# Description:
#   Example scripts for you to examine and try out.
#
# Notes:
#   These are from the scripting documentation: https://github.com/github/hubot/blob/master/docs/scripting.md

module.exports = (robot) ->

  robot.hear /badger/i, (res) ->
    res.message.reactions.add 'badger'
    res.send "Badgers? BADGERS? WE DON'T NEED NO STINKIN BADGERS"

  robot.hear /beard/i, (res) -> 
    res.message.reactions.add 'oestrich'
  
  robot.hear /leporidae/i, (res) -> 
    res.message.reactions.add 'rabbit'
    messageData = {
      channel: res.message.room,
      text: ':rabbit: :rabbit2:'
    }
    res.send messageData
  
  robot.topic (res) ->
    res.send "#{res.message.text}? That's a Paddlin'"
