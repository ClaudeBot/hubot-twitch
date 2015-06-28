# Description:
#   Twitch Public API
#
# Configuration:
#   TWITCH_API_KEY
#   TWITCH_MAX_RESULTS
#   TWITCH_STORAGE_KEY
#
# Commands:
#   hubot ttv follows - Returns the 10 most recent live streams belonging to your followed channels (list populated from your linked Twitch user)
#   hubot ttv link <user> - Link Twitch <user> to you
#   hubot ttv featured - Returns the first TWITCH_MAX_RESULTS (or 5) featured live streams
#   hubot ttv game <category> - Returns the first TWITCH_MAX_RESULTS (or 5) live streams in a game <category> (case-sensitive)
#   hubot ttv search <query> - Returns the first TWITCH_MAX_RESULTS (or 5) live streams matching the search <query>
#   hubot ttv stream <name> - Returns information about stream <name>
#   hubot ttv top - Returns the top TWITCH_MAX_RESULTS (or 5) games sorted by the number of current viewers on Twitch, most popular first
#
# Author:
#   MrSaints
#   mbwk

#
# Config
#
TWITCH_API_KEY = process.env.TWITCH_API_KEY
TWITCH_MAX_RESULTS = process.env.TWITCH_MAX_RESULTS or 5
TWITCH_STORAGE_KEY = process.env.TWITCH_STORAGE_KEY or "_twitch"

module.exports = (robot) ->
    if not TWITCH_API_KEY?
        robot.logger.warning "hubot-twitch: Missing TWITCH_API_KEY in environment. Setting an API key is highly recommended."

    GetTTVData = ->
        robot.brain.data[TWITCH_STORAGE_KEY] or= {}

    robot.respond /ttv follows/i, (res) ->
        user = res.message.user.name.toLowerCase()
        if twitchUser = GetTTVData()[user]
            GetTwitchResult res, "/users/#{twitchUser}/follows/channels", { limit: 10, sortby: "last_broadcast" }, (followsObj) ->
                if followsObj._total is 0 or followsObj.status is 404
                    res.reply "Your Twitch account is not following anyone or it does not exist."
                    return
                total = 0
                processing = followsObj.follows.length
                for followedChannel, index in followsObj.follows
                    GetTwitchResult res, "/streams/#{followedChannel.channel.name}", null, (object) ->
                        --processing
                        if object.status isnt 404 and object.stream
                            ++total
                            channel = object.stream.channel
                            res.send "#{channel.display_name} is streaming \"#{channel.status}\" @ #{channel.url}"
                        if processing is 0
                            if total is 0
                                total = "None"
                            else if total >= 10
                                total += " or more"
                            return res.reply "#{total} of your followed channels are currently streaming."
        else
            res.reply "You have not linked your Twitch account yet."

    robot.respond /ttv link (.+)/i, (res) ->
        user = res.message.user.name.toLowerCase()
        twitchUser = res.match[1]

        GetTwitchResult res, "/users/#{twitchUser}", null, (object) ->
            if object.status is 404
                res.reply "The user you have entered (\"#{twitchUser}\") does not exist."
                return

            GetTTVData()[user] = twitchUser
            robot.brain.save()
            res.reply "Twitch user \"#{twitchUser}\" is now linked to you."

    robot.respond /ttv featured/i, (res) ->
        GetTwitchResult res, '/streams/featured', null, (object) ->
            response = ""
            for feature in object.featured
                channel = feature.stream.channel
                response += "#{feature.stream.game}: #{channel.display_name} (\"#{channel.status}\") - #{channel.url} [Viewers: #{feature.stream.viewers}]\n"
            res.send response

    robot.respond /ttv game (.+)/i, (res) ->
        category = res.match[1]
        GetTwitchResult res, '/streams', { game: category }, (object) ->
            if object._total is 0
                res.reply "No live streams were found in \"#{category}\". Try a different category or try again later."
                return

            response = ""
            for stream in object.streams
                channel = stream.channel
                response += "#{channel.display_name} (\"#{channel.status}\"): #{channel.url} [Viewers: #{stream.viewers}]\n"
            res.send response

            if object._total > TWITCH_MAX_RESULTS
                res.reply "There are #{object._total - TWITCH_MAX_RESULTS} other \"#{category}\" live streams."

    robot.respond /ttv search (.+)/i, (res) ->
        query = res.match[1]
        GetTwitchResult res, "/search/streams", { q: query }, (object) ->
            if object._total is 0
                res.reply "No live streams were found using search query: \"#{query}\". Try a different query or try again later."
                return

            response = ""
            for stream in object.streams
                channel = stream.channel
                response += "#{channel.display_name} (\"#{channel.status}\"): #{channel.url} [Viewers: #{stream.viewers}]\n"
            res.send response

            if object._total > TWITCH_MAX_RESULTS
                res.reply "There are #{object._total - TWITCH_MAX_RESULTS} other live streams matching your search query: \"#{query}\"."

    robot.respond /ttv stream (.+)/i, (res) ->
        GetTwitchResult res, "/streams/#{res.match[1]}", null, (object) ->
            if object.status is 404
                res.reply "The stream you have entered (\"#{res.match[1]}\") does not exist."
                return

            if not object.stream
                res.reply "The stream you have entered (\"#{res.match[1]}\") is currently offline. Try again later."
                return

            channel = object.stream.channel
            response = "#{channel.display_name} is streaming #{channel.game} @ #{channel.url}\n"
            response += "Stream status: #{channel.status}\n"
            response += "Viewers: #{object.stream.viewers}"
            res.send response

    robot.respond /ttv top/i, (res) ->
        createGameURL = (game) ->
            "https://www.twitch.tv/directory/game/#{encodeURIComponent(game)}"

        GetTwitchResult res, "/games/top", null, (object) ->
            response = ""
            for gameObj, i in object.top
                response += "#{i + 1}. #{gameObj.game.name} | Viewers: #{gameObj.viewers} | Channels: #{gameObj.channels} | #{createGameURL(gameObj.game.name)}\n"
            res.send response

GetTwitchResult = (res, api, params = {}, handler) ->
    params.client_id = TWITCH_API_KEY
    params.limit or= TWITCH_MAX_RESULTS
    res.http("https://api.twitch.tv/kraken#{api}")
        .query(params)
        .get() (err, httpRes, body) ->
            if err or httpRes.statusCode isnt 200
                err = "503 Service Unavailable" if httpRes.statusCode is 503
                res.reply "An error occurred while attempting to process your request."
                return res.robot.logger.error "hubot-twitch: #{err}"

            handler JSON.parse(body)