require "box2d"

level1 = Core.class(Sprite)

function level1:init()

	self.world = b2.World.new(0.0, 10, true)

	screenW = application:getContentWidth()
	screenH = application:getContentHeight()

local wallColour = 0xff0000

	-- walls 
	self:addChild(wall.new(self.world, 0, conf.maxy/2, 10, conf.maxy, wallColour, 0))
	self:addChild(wall.new(self.world, conf.maxx/2, 0, conf.maxx, 10, wallColour, 0))
	self:addChild(wall.new(self.world, conf.maxx, conf.maxy/2, 10, conf.maxy, wallColour, 0))
	self:addChild(wall.new(self.world, conf.maxx/2, conf.maxy, conf.maxx, 10, wallColour, 0))
	self:addChild(wall.new(self.world, 435,100, 5,50, wallColour, 90))
	
	-- ball
	self.myBall = ball.new(self.world,25, screenH - 50, conf.ballImage)
	self:addChild(self.myBall)
	
	-- bricks
	self:addChild(brick.new(self.world,280, screenH - 20))
	self:addChild(brick.new(self.world,280, screenH - 50))
	self:addChild(brick.new(self.world,280, screenH - 80))
	self:addChild(brick.new(self.world,280, screenH - 100))
	
	self:addChild(brick.new(self.world,400, screenH - 60))
	self:addChild(brick.new(self.world,400, screenH - 20))
	
	-- orb
	self:addChild(orb.new(self.world,435, 60, "images/orb.png", 10))
	self:addChild(orb.new(self.world,405, 195, "images/yelloworb.png", 20))
	self:addChild(orb.new(self.world,280,160, "images/redorb.png", 30))

	self.points = 0 
	self.go = false 
	self.moves = 0
	self.xV = 15
	self.yV = 10
	self.hasshoot = false 
	self.ballTouch = false 
	self.strength = 100

	self.angMess = {}
	for i = 1, 2 do 
		self.angMess[1] = TextField.new(nil, "X")
		self.angMess[1]:setPosition(35,175)
		self.angMess[2] = TextField.new(nil, "Y")
		self.angMess[2]:setPosition(113, 175)

		self.angMess[i]:setScale(2)
		self:addChild(self.angMess[i])
	end 

	self.angMess2 = {}

	for i = 1, 2 do 
		self.angMess2[1] = TextField.new(nil, "Power") -- Power / Speed
		self.angMess2[2] = TextField.new(nil, "Power") -- Power / Speed

		self.angMess2[1]:setPosition(10,190)
		self.angMess2[2]:setPosition(90,190)

		self.angMess2[i]:setScale(2)
		self:addChild(self.angMess2[i])
	end 

	self.xPowerText = TextField.new(nil, self.xV) 
	self.xPowerText:setPosition(30, 210)
	self.xPowerText:setScale(2)
	self:addChild(self.xPowerText)

	self.yPowerText = TextField.new(nil, self.yV) 
	self.yPowerText:setPosition(113, 210)
	self.yPowerText:setScale(2)
	self:addChild(self.yPowerText)

	self.scoreText = TextField.new(nil, "Score:") 
	self.scoreText:setPosition(405, 20)
	self.scoreText:setScale(2)
	self:addChild(self.scoreText)

	self.movesText = TextField.new(nil, self.moves) 
	self.movesText:setPosition(74, 120)
	self.movesText:setScale(2.5)
	self:addChild(self.movesText)

	self.pointsText = TextField.new(nil, self.points) 
	self.pointsText:setPosition(405 + 25 , 40)
	self.pointsText:setScale(2)
	self:addChild(self.pointsText)

	self.goBtn = Bitmap.new(Texture.new("images/pause_play_stop_black.png"))
	self.goBtn:setPosition(10,10)
	self.goBtn:setScale(0.09)
	self:addChild(self.goBtn)

	self.updownBtn = Bitmap.new(Texture.new("images/updown.png"))
	self.updownBtn:setPosition(self.goBtn:getX() + 10, 70)
	self.updownBtn:setScale(0.06)
	self:addChild(self.updownBtn)

	self.updownBtnPwr = Bitmap.new(Texture.new("images/updown.png"))
	self.updownBtnPwr:setPosition(self.goBtn:getX() + 87, 70)
	self.updownBtnPwr:setScale(0.06)
	self:addChild(self.updownBtnPwr)

	self.pressPlay = Bitmap.new(Texture.new("images/pressplay.png"))
	self.pressPlay:setPosition(10,10)
	self.pressPlay:setScale(0.09)
	self:addChild(self.pressPlay)
	self.pressPlay:setVisible(false)

	self.pressPause = Bitmap.new(Texture.new("images/presspause.png"))
	self.pressPause:setPosition(10,10)
	self.pressPause:setScale(0.09)
	self:addChild(self.pressPause)
	self.pressPause:setVisible(false)

	homeButton = Bitmap.new(Texture.new("images/homebutton.png"))
	homeButton:setScale(.03)
	homeButton:setPosition(60, 57)
	self:addChild(homeButton)

	self.world:addEventListener(Event.BEGIN_CONTACT, self.onBeginContact, self)
	
    self:addEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)
	self:addEventListener("exitBegin", self.onExitBegin, self)
	self:addEventListener(Event.MOUSE_UP, self.msUp, self )
end 

function level1:onEnterFrame() 
	
	self.world:step(1/60, 8, 3)
	
	for i = 1, self:getNumChildren() do
	
		local sprite = self:getChildAt(i)
		
		if sprite.body then
			if sprite.body.type == "orb" then 
				if sprite.body.changescale then 
					sprite:changescale(self.world)
				end
			end 
			
			local body = sprite.body
			local bodyX, bodyY = body:getPosition()
			sprite:setPosition(bodyX, bodyY)
			sprite:setRotation(body:getAngle() * 180 / math.pi)
			
			if self.points == 60 and conf.onLevel == 1 then 	
				conf.onLevel = 2
				sceneManager:changeScene("start", conf.transitionTime * 3 , conf.transition, conf.easing)  

			elseif  self.points == 60 and conf.onLevel ~= 1 then 
				sceneManager:changeScene("start", conf.transitionTime * 3, conf.transition, conf.easing) 
			end
			
			
		end
	end

end

function level1:onBeginContact(event)
	
	local fixtureA = event.fixtureA
	local fixtureB = event.fixtureB
	local bodyA = fixtureA:getBody()
	local bodyB = fixtureB:getBody()
	local spriteA = fixtureA.sprite
	
	
	if bodyA.type == "ball" and bodyB.type == "orb" then  
		ballTouch = true  
	

		bodyB.scalefactor = bodyB.scalefactor / 1.8
		bodyB.changescale = true 
	
		self.points = self.points + bodyB.value
	
		conf.wallet = conf.wallet + bodyB.value
		print(conf.wallet)
	
		bodyB.value = 0 

		self.pointsText:setText(self.points)
		
	end



	if bodyA.type == "ice" and bodyB.type == "ball" then
	
		bodyA.strength = bodyA.strength - 10 
	end 
end 
	
	 
	 
function level1:onExitBegin()
	self:removeEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)
	self:removeEventListener(Event.MOUSE_UP, self.msUp, self)

	self:removeEventListener(Event.BEGIN_CONTACT, self.onBeginContact, self)
end
	  
	 




function level1:msUp(event)
	local x = event.x
	local y = event.y
	
	if homeButton:hitTestPoint(x, y) then 
		event:stopPropagation()
		sceneManager:changeScene("start", conf.transitionTime * 2, conf.transition, conf.easing)
	end 
	
	if self.pressPlay:hitTestPoint(x, y) then
		if x < (self.pressPlay:getWidth() / 2) and self.go == false then 
			self.hasshoot = true 
			self.go = true 
			self.myBall.body:applyLinearImpulse(self.xV, self.yV, self.myBall:getX(), self.myBall:getY())
			event:stopPropagation()
	
			self.moves = self.moves + 1
			self.movesText:setText(self.moves)
		
			self.pressPause:setVisible(true)
			self.pressPlay:setVisible(false)

			if self.moves > 9 then 
				self.movesText:setX(74 - 5)
			end 
		end
	end 


	if self.pressPause:hitTestPoint(x, y) then 
		if  x > (self.pressPause:getWidth() / 2) and self.go == true  then 
			self.hasshoot = false 
			self.go = false 
			event:stopPropagation()
			self.pressPlay:setVisible(true)
			self.pressPause:setVisible(false)		
		end 
		
	end 	
		
	local x = event.x 
	local y = event.y 
	
	if self.updownBtn:hitTestPoint(x, y) then 
		if y > self.updownBtn:getY() + (self.updownBtn:getHeight() / 2) then -- Down Button 
			self.xV = self.xV - 5 
		
			if self.xV < 0 then 
				self.xV = 0 
			end 
		
			print("Horizontal Velocity "..self.xV)
			self.xPowerText:setText(self.xV)
		
		elseif y < self.updownBtn:getY() + (self.updownBtn:getHeight() / 2) then -- Up Button 
		
			self.xV = self.xV + 5
			print("Horizontal Velocity "..self.xV)
			self.xPowerText:setText(self.xV)
		end 
	end 
	
	if self.updownBtnPwr:hitTestPoint(x, y) then 
		if y > self.updownBtn:getY() + (self.updownBtn:getHeight() / 2) then -- Down Button 
		
			self.yV = self.yV - 5
		
			if self.yV < 0 then 
				self.yV = 0 
			end 
		
			print("Vertical Velocity "..self.yV)
			self.yPowerText:setText(self.yV)
		
		elseif y < self.updownBtn:getY() + (self.updownBtn:getHeight() / 2) then -- Up Button 
		
			self.yV = self.yV + 5
			print("Vertical Velocity "..self.yV)
			self.yPowerText:setText(self.yV)
		end 
	end 

end 


	
function level1:onExitBegin()
	self:removeEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)
	self:removeEventListener(Event.BEGIN_CONTACT, self.onBeginContact, self)
end


