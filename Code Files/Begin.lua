require "box2d"

BeginScene = Core.class(Sprite)

function BeginScene:init()

	self.world = b2.World.new(0 ,0 ,false)

	screenW = application:getContentWidth()
	screenH = application:getContentHeight()

	local wallColour = 0xff0000

	playBTN = Bitmap.new(Texture.new("images/play.png"))
	playBTN:setPosition(180, 50)
	playBTN:setScale(.08)
	self:addChild(playBTN)

	Cart = Bitmap.new(Texture.new("images/shoppingcart.png"))
	Cart:setPosition(300, 50)
	Cart:setScale(.05)
	self:addChild(Cart)

	-- walls 
	self:addChild(wall.new(self.world, 0, conf.maxy/2, 10, conf.maxy, wallColour, 0))
	self:addChild(wall.new(self.world, conf.maxx/2, 0, conf.maxx, 10, wallColour, 0))
	self:addChild(wall.new(self.world, conf.maxx, conf.maxy/2, 10, conf.maxy, wallColour, 0))
	self:addChild(wall.new(self.world, conf.maxx/2, conf.maxy, conf.maxx, 10, wallColour, 0))
	
	-- ball
	self.myBall = ball.new(self.world,25, screenH - 50, conf.ballImage)
	self:addChild(self.myBall)
	
	-- bricks
	self:addChild(brick.new(self.world,200, screenH - 20))
	self:addChild(brick.new(self.world,200, screenH - 25))
	self:addChild(brick.new(self.world,200, screenH - 30))
	self:addChild(brick.new(self.world,200, screenH - 35))
	
	self:addChild(brick.new(self.world,300, screenH - 25))
	self:addChild(brick.new(self.world,300, screenH - 20))
	
	self:addChild(brick.new(self.world,600, screenH - 20))
	self:addChild(brick.new(self.world,600, screenH - 25))
	
	-- orb
	self:addChild(orb.new(self.world,435, 60, "images/orb.png", 10))
	self:addChild(orb.new(self.world,405, 195, "images/yelloworb.png", 20))
	self:addChild(orb.new(self.world,280,160, "images/redorb.png", 30))
	
	self.myBall.body:applyLinearImpulse(math.random(30,50), math.random(25,40), self.myBall:getX(), self.myBall:getY())
	

    self:addEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)
	self:addEventListener(Event.MOUSE_UP, self.msUp, self )
end 

function BeginScene:onEnterFrame() 

	self.world:step(1/60, 80, 15)
	
	for i = 1, self:getNumChildren() do
		
		local sprite = self:getChildAt(i)
		
		if sprite.body then
         
			local body = sprite.body
			local bodyX, bodyY = body:getPosition()
			sprite:setPosition(bodyX, bodyY)
			sprite:setRotation(body:getAngle() * 180 / math.pi)
		end
	end

end

function BeginScene:msUp(event)
	local x = event.x
	local y = event.y
	
	if playBTN:hitTestPoint(x, y) then 
	 
		event:stopPropagation()
		sceneManager:changeScene("start", conf.transitionTime * 2, conf.transition, conf.easing)
	 
	elseif Cart:hitTestPoint(x, y) then 
	 
		event:stopPropagation()
		sceneManager:changeScene("StoreScene", conf.transitionTime * 2, conf.transition, conf.easing)
	 
	end 
end