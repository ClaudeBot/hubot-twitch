# hubot-twitch

[![Build Status](https://travis-ci.org/ClaudeBot/hubot-twitch.svg)](https://travis-ci.org/ClaudeBot/hubot-twitch)
[![devDependency Status](https://david-dm.org/ClaudeBot/hubot-twitch/dev-status.svg)](https://david-dm.org/ClaudeBot/hubot-twitch#info=devDependencies)

A Hubot script for interacting with Twitch.tv API.

See [`src/twitch.coffee`](src/twitch.coffee) for full documentation.


## Installation via NPM

1. Install the __hubot-twitch__ module as a Hubot dependency by running:

    ```
    npm install --save hubot-twitch
    ```

2. Enable the module by adding the __hubot-twitch__ entry to your `external-scripts.json` file:

    ```json
    [
        "hubot-twitch"
    ]
    ```

3. Run your bot and see below for available config / commands


## Configuration

Variable | Default | Description
--- | --- | ---
`TWITCH_API_KEY` | N/A | _(Optional)_ To avoid any restrictions when using Twitch API, please [register your application](http://www.twitch.tv/settings/connections) and set your application [client ID](https://github.com/justintv/Twitch-API/blob/master/authentication.md#developer-setup) using this config
`TWITCH_MAX_RESULTS` | 5 | The maximum number of result(s) to return
`TWITCH_STORAGE_KEY` | _twitch | The unique key used for persistence (storing/retrieving users' Twitch-related data from memory)


## Commands

Command | Description
--- | ---
hubot ttv follows | Returns the 10 most recent live streams belonging to your followed channels (list populated from your linked Twitch user, see command below)
hubot ttv link `user` | Link Twitch `user` to you
hubot ttv featured | Returns the first `TWITCH_MAX_RESULTS` (or 5) featured live streams
hubot ttv game `category` | Returns the first `TWITCH_MAX_RESULTS` (or 5) live streams in a game `category` (case-sensitive)
hubot ttv search `query` | Returns the first `TWITCH_MAX_RESULTS` (or 5) live streams matching the search `query`
hubot ttv stream `name` | Returns information about stream `name`
hubot ttv top | Returns the top `TWITCH_MAX_RESULTS` (or 5) games sorted by the number of current viewers on Twitch, most popular first


## Sample Interaction

```
user1>> hubot ttv follows
hubot>> Dendi is streaming "<:::::[]=¤༼ຈل͜ຈ༽ﾉ FOR THE WATCH" @ http://www.twitch.tv/dendi
hubot>> Sing_sing is streaming "newbie dota player" @ http://www.twitch.tv/sing_sing
hubot>> user1: 2 of your followed channels are currently streaming.
```
