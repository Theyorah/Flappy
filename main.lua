local best = 0
local death = -1

function	love.load()
	death = death + 1
	score = 0

	gravity = 1

	player = {}
	player.velocity = 0
	player.size = 15
	player.x = love.graphics.getWidth() / 2
	player.y = love.graphics.getHeight() / 2

	pipe = {}
	speed = 450
	size = 75

	pipe.pipe1 = {}
	pipe.pipe1.scored = false
	pipe.pipe1.x = love.graphics.getWidth() + 500
	pipe.pipe1.y = 300
	
	pipe.pipe2 = {}
	pipe.pipe2.scored = false
	pipe.pipe2.x = love.graphics.getWidth() + 1000
	pipe.pipe2.y = 300
end

function	love.update(dt)

	--[[PIPES MOVEMENT MADAFAKA]]
	for i, pipes in pairs(pipe) do
		if pipes.x <= - 100 then
			pipes.x = love.graphics.getWidth() + 100
			pipes.y = (love.math.random(love.math.getRandomSeed()) % 400) + 100
			pipes.scored = false
		end
		pipes.x = pipes.x - (speed * dt)
	end

	--[[SCORING MADAFAKA]]
	for i, pipes in pairs(pipe) do
		if pipes.scored == false and (pipes.x + size) < (player.x - player.size) then
			pipes.scored = true
			score = score + 1
		end
	end 
	if score > best then
		best = score
	end

	--[[GAME OVAH MADAFAKA]]
	for i, pipes in pairs(pipe) do
		if (((player.x + player.size) < (pipes.x + size)) and ((player.x + player.size) > pipes.x)) or (((player.x - player.size) < (pipes.x + size)) and ((player.x - player.size) > pipes.x)) or player.y > love.graphics.getHeight() then
			if (player.y + player.size) > (pipes.y + size) or (player.y - player.size) < (pipes.y - size) then
				love.load()
			end
		end
	end

	--[[PLAYAH MOVEMENT MADAFAKA]]
	player.velocity = player.velocity + gravity
	gravity = gravity + 5
	player.y = player.y + (player.velocity * dt)
end

function	love.draw()
	love.graphics.setColor(0.15, 0.14, 0.18)
	love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())

	love.graphics.setColor(0, 0, 0)
	love.graphics.circle("fill", player.x, player.y, player.size + 5)
	love.graphics.rectangle("fill", player.x, player.y - (player.size + 5) / 2.5, (player.size + 5) * 1.5, player.size + 5)

	love.graphics.setColor(1, 1, 0)
	love.graphics.circle("fill", player.x, player.y, player.size)

	love.graphics.setColor(1, 0.1, 0.1)
	love.graphics.rectangle("fill", player.x, player.y - player.size / 2.5, player.size * 1.5, player.size)

	love.graphics.setColor(0, 0, 0)
	for i, pipes in pairs(pipe) do
		love.graphics.rectangle("fill", pipes.x, pipes.y - love.graphics.getHeight() - size, size, love.graphics.getHeight())
		love.graphics.rectangle("fill", pipes.x, pipes.y + size, size, love.graphics.getHeight())
	end

	love.graphics.setColor(0.2, 0.8, 0.2)
	for i, pipes in pairs(pipe) do
		love.graphics.rectangle("fill", pipes.x + 5, pipes.y - 5 - love.graphics.getHeight() - size, size - 10, love.graphics.getHeight(), 0, 500)
		love.graphics.rectangle("fill", pipes.x + 5, pipes.y + 5 + size, size - 10, love.graphics.getHeight())
	end

	love.graphics.setColor(1, 1, 1)
	love.graphics.print(score, love.graphics.getWidth() / 2, 0)
	love.graphics.print("Your best: " .. best, 0, 0)
	love.graphics.print("Deaths: " .. death, 0, 15)
end

function	love.keyreleased(key)
	if key == "space" then
		player.velocity = -555
		gravity = 1
	end

	if key == "escape" then
		love.window.close()
	end
end