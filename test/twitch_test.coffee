chai = require "chai"
sinon = require "sinon"
chai.use require "sinon-chai"

expect = chai.expect

describe "twitch", ->
    beforeEach ->
        @robot =
            respond: sinon.spy()

        require("../src/twitch")(@robot)

    it "registers a respond listener", ->
        expect(@robot.respond).to.have.been.calledWith(/ttv follows/i)
        expect(@robot.respond).to.have.been.calledWith(/ttv link (.+)/i)
        expect(@robot.respond).to.have.been.calledWith(/ttv featured/i)
        expect(@robot.respond).to.have.been.calledWith(/ttv game (.+)/i)
        expect(@robot.respond).to.have.been.calledWith(/ttv search (.+)/i)
        expect(@robot.respond).to.have.been.calledWith(/ttv stream (.+)/i)
        expect(@robot.respond).to.have.been.calledWith(/ttv top/i)