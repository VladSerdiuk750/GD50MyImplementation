--[[
    ScoreState Class
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    A simple state used to display the player's score before they
    transition back into the play state. Transitioned to from the
    PlayState when they collide with a Pipe.
]]

ScoreState = Class{__includes = BaseState}

local gold = love.graphics.newImage('gold.png')
local silver = love.graphics.newImage('silver.png')
local bronze = love.graphics.newImage('bronze.png')
local wood = love.graphics.newImage('wood.png')

--[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]
function ScoreState:enter(params)
    self.score = params.score
end

function ScoreState:update(dt)
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function ScoreState:render()
    -- simply render the score to the middle of the screen
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Oof! You lost!', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')


    if self.score == 0 then 
        love.graphics.draw(wood, VIRTUAL_WIDTH / 2 - ((wood:getWidth()*0.1/2)), 0, 0, 0.1)
    elseif self.score > 0 then
        if self.score > 9 then
            if self.score > 14 then 
                love.graphics.draw(gold, VIRTUAL_WIDTH / 2 - ((gold:getWidth()*0.1/2)), 0, 0, 0.1)
            else 
                love.graphics.draw(silver, VIRTUAL_WIDTH / 2 - ((silver:getWidth()*0.15/2)), 0, 0, 0.15)
            end
        else
            love.graphics.draw(bronze, VIRTUAL_WIDTH / 2 - ((bronze:getWidth()*0.25/2)), 0, 0, 0.25)
        end
    end

    love.graphics.printf('Press Enter to Play Again!', 0, 160, VIRTUAL_WIDTH, 'center')
end