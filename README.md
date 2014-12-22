# Hubot: Twitch.tv

A Hubot script for interacting with Twitch.tv API.


## Installation via NPM

1. Install the __hubot-twitch__ module as a Hubot dependency by adding it to your `package.json` file:

    ```
    npm install --save hubot-twitch
    ```

2. Enable the script by adding the __hubot-twitch__ entry to your `external-scripts.json` file:

    ```json
    ["hubot-twitch"]
    ```

3. Run `npm install`


## Config

- `TWITCH_API_KEY`
- `HUBOT_TWITCH_KEY`
- `HUBOT_TWITCH_MAX_RESULTS` _(TBA)_


## Commands

Command | Description
--- | ---
hubot ttv follows | Returns the 10 most recent live streams belonging to your followed channels (list populated from your linked Twitch user)
hubot ttv link `user` | Link Twitch `user` to you
hubot ttv featured | Returns the first 5 featured live streams
hubot ttv game `category` | Returns the first 5 live streams in a game `category` (case-sensitive)
hubot ttv search `query` | Returns the first 5 live streams matching the search `query`
hubot ttv stream `name` | Returns information about stream `name`
hubot ttv top | Returns the top 5 games sorted by the number of current viewers on Twitch, most popular first