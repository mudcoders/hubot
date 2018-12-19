# Description:
#   Allows Hubot to archive links found in slack conversations in elasticsearch
#
# Commands:
#   hubot archive status - Retuns the status of the archive
#
# Configuration:
#   ELASTICSEARCH_HOST hostname of the elastic search cluster
#   ELASTICSEARCH_PORT port of the elastic search cluster
#   ELASTICSEARCH_INDEX elastic search index to used for archiving
#
# Notes:
#   Forked from https://github.com/peri4n/hubot-archive by Fabian Bull <fabian.bull@datameer.com>
#
# Author:
#   Zachary Flower <zach@mudcoders.com>

module.exports = (robot) ->

  if(process.env.BONSAI_URL)
    ELASTICSEARCH_CLUSTER = process.env.BONSAI_URL
  else
    ELASTICSEARCH_HOST = "http://localhost"
    ELASTICSEARCH_PORT = ""

    if(process.env.ELASTICSEARCH_HOST?)
      ELASTICSEARCH_HOST = process.env.ELASTICSEARCH_HOST

    if(process.env.ELASTICSEARCH_PORT?)
      ELASTICSEARCH_PORT = process.env.ELASTICSEARCH_PORT

    ELASTICSEARCH_CLUSTER = "#{ELASTICSEARCH_HOST}:#{ELASTICSEARCH_PORT}"

  ELASTICSEARCH_INDEX = "archive"

  if(process.env.ELASTICSEARCH_INDEX?)
    ELASTICSEARCH_INDEX = process.env.ELASTICSEARCH_INDEX

  # archive all shared links
  robot.hear /https?:\/\/((?!giphy))/i, (res) ->
    robot.http("#{ELASTICSEARCH_CLUSTER}/#{ELASTICSEARCH_INDEX}/_doc/#{res.message.id}?pretty")
    .header('Content-Type', 'application/json')
    .put(JSON.stringify(res.message)) (err, response, body) ->
      if err
        console.error("Error archiving link from #{res.message.user.name} in #{res.message.room} with id #{res.message.id}", err)
      else
        console.log("Archiving link from #{res.message.user.name} in #{res.message.room} with id #{res.message.id}", body)

  # check status of elastic search endpoint
  robot.respond /archive status/i, (res) ->
    robot.http("#{ELASTICSEARCH_CLUSTER}/#{ELASTICSEARCH_INDEX}/_cat/indices?v")
    .header('Content-Type', 'application/json')
    .put(JSON.stringify(res.message)) (err, response, body) ->
      if err
        console.error("Error connecting to Elasticsearch cluster", err)
        res.send("Something is wrong with the archive :worried:")
      else
        console.log("Successfully connected to Elasticsearch cluster", body)
        res.send("Everything looks good :thumbsup:")

  # get the archive
  robot.respond /archive dump/i, (res) ->
    robot.http("#{ELASTICSEARCH_CLUSTER}/#{ELASTICSEARCH_INDEX}/_search?pretty=true&q=*:*&size=100")
    .header('Content-Type', 'application/json')
    .put(JSON.stringify(res.message)) (err, response, body) ->
      if err
        console.error("Error connecting to Elasticsearch cluster", err)
        res.send("Something is wrong with the archive :worried:")
      else
        console.log("Successfully connected to Elasticsearch cluster", body)
        res.send(body)
        res.send(response)