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

- TWITCH_API_KEY
- HUBOT_TWITCH_KEY
- HUBOT_TWITCH_MAX_RESULTS _(TBA)_


## Commands

Command | Description
--- | ---
hubot ttv __follows__ | Returns the 10 most recent live streams belonging to your followed channels (list populated from your linked Twitch user)
hubot ttv __link__ _\<user\>_ | Link Twitch _\<user\>_ to you
hubot ttv __featured__ | Returns the first 5 featured live streams
hubot ttv __game__ _\<category\>_ | Returns the first 5 live streams in a game _\<category\>_ (case-sensitive)
hubot ttv __search__ _\<query\>_ | Returns the first 5 live streams matching the search _\<query\>_
hubot ttv __stream__ _\<name\>_ | Returns information about stream _\<name\>_
hubot ttv __top__ | Returns the top 5 games sorted by the number of current viewers on Twitch, most popular first