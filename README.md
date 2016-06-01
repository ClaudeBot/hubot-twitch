# hubot-twitch

[![Build Status](https://travis-ci.org/ClaudeBot/hubot-twitch.svg)](https://travis-ci.org/ClaudeBot/hubot-twitch)
[![devDependency Status](https://david-dm.org/ClaudeBot/hubot-twitch/dev-status.svg)](https://david-dm.org/ClaudeBot/hubot-twitch#info=devDependencies)

A Hubot script for interacting with [Twitch.tv][twitch] API.

See [`src/twitch.coffee`](src/twitch.coffee) for full documentation.


---


**Attention:** [Starting from the 8th of August 2016][kraken], including the `Client-ID` in the header of all API requests has become a requirement by [Twitch.tv][twitch]. It was previously an OPTIONAL configuration option. This is no longer the case.

You can obtain the `Client-ID` from the [Connections](https://www.twitch.tv/settings/connections) page in your settings. You can then set this in your Hubot environment using:

```bash
export TWITCH_API_KEY="YOUR CLIENT ID HERE"
```

If you are already doing the above, you will have nothing to worry about.


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
`TWITCH_API_KEY` | N/A | _(Required)_ To avoid any restrictions when using Twitch API, please [register your application](http://www.twitch.tv/settings/connections) and set your application [client ID](https://github.com/justintv/Twitch-API/blob/master/authentication.md#developer-setup) using this config
`TWITCH_MAX_RESULTS` | 5 | The maximum number of result(s) to return
`TWITCH_STORAGE_KEY` | _twitch | The unique key used for persistence (storing/retrieving users' Twitch-related data from memory)


## Commands

Command | Listener ID | Description
--- | --- | ---
hubot ttv follows | `twitch.follows` | Returns the 10 most recent live streams belonging to your followed channels (list populated from your linked Twitch user, see command below)
hubot ttv link `user` | `twitch.link` | Link Twitch `user` to you
hubot ttv featured | `twitch.featured` | Returns the first `TWITCH_MAX_RESULTS` (or 5) featured live streams
hubot ttv game `category` | `twitch.game` | Returns the first `TWITCH_MAX_RESULTS` (or 5) live streams in a game `category` (case-sensitive)
hubot ttv search `query` | `twitch.search` | Returns the first `TWITCH_MAX_RESULTS` (or 5) live streams matching the search `query`
hubot ttv stream `name` | `twitch.stream` | Returns information about stream `name`
hubot ttv top | `twitch.top` | Returns the top `TWITCH_MAX_RESULTS` (or 5) games sorted by the number of current viewers on Twitch, most popular first


## Sample Interaction

```
user1>> hubot ttv follows
hubot>> Dendi is streaming "<:::::[]=¤༼ຈل͜ຈ༽ﾉ FOR THE WATCH" @ http://www.twitch.tv/dendi
hubot>> Sing_sing is streaming "newbie dota player" @ http://www.twitch.tv/sing_sing
hubot>> user1: 2 of your followed channels are currently streaming.
```


[twitch]: https://www.twitch.tv/
[kraken]: https://blog.twitch.tv/client-id-required-for-kraken-api-calls-afbb8e95f843