require "box2d"

StoreScene = Core.class(Sprite)

function StoreScene:init()

	self.world = b2.World.new(0 ,0 ,false)
	screenW = application:getContentWidth()
	screenH = application:getContentHeight()

	for i = 1, 7 do 
		self:addChild(conf.priceText[i])
	end 

	conf.priceText[1]:setPosition(228, 100)
	conf.priceText[2]:setPosition(300, 100)
	conf.priceText[3]:setPosition(375, 100)

	conf.priceText[4]:setPosition(147, 225)
	conf.priceText[5]:setPosition(223, 225)
	conf.priceText[6]:setPosition(300, 225)
	conf.priceText[7]:setPosition(373, 225)

	self.walletText = TextField.new(nil,"$".. conf.wallet) 
	self.walletText:setScale(2)
	self.walletText:setPosition(45,170)
	self:addChild(self.walletText)
	
	homeButton = Bitmap.new(Texture.new("images/homebutton.png"))
	homeButton:setScale(.04)
	homeButton:setPosition(45, 70)
	self:addChild(homeButton)

	wallColour = 0xff0000
	
	-- Walls 
	self:addChild(wall.new(self.world, 0, conf.maxy/2, 10, conf.maxy, wallColour, 0))
	self:addChild(wall.new(self.world, conf.maxx/2, 0, conf.maxx, 10, wallColour, 0))
	self:addChild(wall.new(self.world, conf.maxx, conf.maxy/2, 10, conf.maxy, wallColour, 0))
	self:addChild(wall.new(self.world, conf.maxx/2, conf.maxy, conf.maxx, 10, wallColour, 0))
		
	self.myBall1 = ball.new(self.world,150 + 25, 175,"images/ball.png" )
	self.myBall1:setScale(1.5)
	self:addChild(self.myBall1)
		
	self.myBall2 = ball.new(self.world,150 + 25,50, "images/circle.png")
	self.myBall2:setScale(1.5)
	self:addChild(self.myBall2)
		
	self.myBall3 = ball.new(self.world,225 + 25, 50, "images/soccerball.png")
	self.myBall3:setScale(1.5)
	self:addChild(self.myBall3)
		
	self.myBall4 = ball.new(self.world,300 + 25, 50, "images/8ball.png")
	self.myBall4:setScale(1.5)
	self:addChild(self.myBall4)
		
	self.myBall5 = ball.new(self.world,375 + 25, 50, "images/bowling.png")
	self.myBall5:setScale(1.5)	self:addChild(self.myBall5) 
		
	self.myBall6 = ball.new(self.world,225 + 25, 175, "images/trippyBall.png")
	self.myBall6:setScale(1.5)
	self:addChild(self.myBall6) 
		
	self.myBall7 = ball.new(self.world,300 + 25, 175, "images/chromeball.png")
	self.myBall7:setScale(1.5)
	self:addChild(self.myBall7) 
		
	self.myBall8 = ball.new(self.world,375 + 25, 175, "images/cameralense.png")
	self.myBall8:setScale(1.5)
	self:addChild(self.myBall8) 
		
	self:addEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)
	self:addEventListener(Event.MOUSE_UP, self.msUp, self )
end 

function StoreScene:onEnterFrame() 

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


function StoreScene:msUp(event)
	local x = event.x
	local y = event.y
	
	function check()
     
		if conf.wallet < 100 then 
			self.walletText:setPosition(47,170)
		elseif conf.wallet > 1000 then
			self.walletText:setPosition(40,170)
		end 
	end 

	if self.myBall1:hitTestPoint(x,y) and conf.wallet >= conf.price[4] and conf.pricesText[4] == true then 
	print("select red ball")
	conf.ballImage = "images/ball.png"
	conf.wallet = conf.wallet - conf.price[4]
	conf.priceText[4]:setVisible(false)
	self.walletText:setText("$"..conf.wallet)
	conf.pricesText[4] = false 
	check()

	elseif self.myBall1:hitTestPoint(x,y) and conf.pricesText[4] == false then 
	print("select red ball")
	conf.ballImage = "images/ball.png"
	self.walletText:setText("$"..conf.wallet)
	conf.pricesText[4] = false 
	check()

	elseif self.myBall2:hitTestPoint(x, y) then 
	print("select plain circle")
	conf.ballImage = "images/circle.png"

	elseif self.myBall3:hitTestPoint(x, y) and conf.wallet >= conf.price[1] and conf.pricesText[1] == true then 
	print("select soccer ball")
	conf.ballImage = "images/soccerball.png"
	conf.wallet = conf.wallet - conf.price[1]
	conf.priceText[1]:setVisible(false)
	check()

	self.walletText:setText("$"..conf.wallet)
	conf.pricesText[1] = false 

	elseif self.myBall3:hitTestPoint(x, y) and conf.pricesText[1] == false then 
	print("select soccer ball")
	conf.ballImage = "images/soccerball.png"
	self.walletText:setText("$"..conf.wallet)
	conf.pricesText[1] = false 
	check()

	elseif self.myBall4:hitTestPoint(x, y) and conf.wallet >= conf.price[2]  and conf.pricesText[2] == true  then 
	print("select 8 ball")
	conf.ballImage = "images/8ball.png"
	conf.wallet = conf.wallet - conf.price[2]
	conf.priceText[2]:setVisible(false)
	self.walletText:setText("$"..conf.wallet)
	conf.pricesText[2] = false 
	check()

	elseif self.myBall4:hitTestPoint(x, y) and conf.pricesText[2] == false then 
	print("select 8 ball")
	conf.ballImage = "images/8ball.png"
	self.walletText:setText("$"..conf.wallet)
	conf.pricesText[2] = false 
	check()

	elseif self.myBall5:hitTestPoint(x, y) and conf.wallet >= conf.price[3] and conf.pricesText[3] == true then 
	print("select bowling ball")
	conf.ballImage = "images/bowling.png"
	conf.wallet = conf.wallet - conf.price[3]
	conf.priceText[3]:setVisible(false)
	self.walletText:setText("$"..conf.wallet)
	conf.pricesText[3] = false 
	check()
	
	elseif self.myBall5:hitTestPoint(x, y) and conf.pricesText[3] == false then 
	print("select bowling ball")
	conf.ballImage = "images/bowling.png"
	self.walletText:setText("$"..conf.wallet)
	conf.pricesText[3] = false 
	check()

	elseif self.myBall6:hitTestPoint(x, y) and conf.wallet >= conf.price[5] and  conf.pricesText[5] == true then 
		print("select graphic ball")
		conf.ballImage = "images/trippyBall.png"
		conf.wallet = conf.wallet - conf.price[5]
		conf.priceText[5]:setVisible(false)
		self.walletText:setText("$"..conf.wallet)
		conf.pricesText[5] = false 
		check()
	
	elseif self.myBall6:hitTestPoint(x, y) and conf.pricesText[5] == false then 
		print("select graphic ball")
		conf.ballImage = "images/trippyBall.png"
		self.walletText:setText("$"..conf.wallet)
		conf.pricesText[5] = false 
		check()

	elseif self.myBall7:hitTestPoint(x, y) and conf.wallet >= conf.price[6] and  conf.pricesText[6] == true then 
		print("select chrome ball")
		conf.ballImage = "images/chromeball.png"
		conf.wallet = conf.wallet - conf.price[6]
		conf.priceText[6]:setVisible(false)
		self.walletText:setText("$"..conf.wallet)
		conf.pricesText[6] = false 
		check()
	
	elseif self.myBall7:hitTestPoint(x, y) and conf.pricesText[6] == false then 
		print("select chrome ball")
		conf.ballImage = "images/chromeball.png"
		self.walletText:setText("$"..conf.wallet)
		conf.pricesText[6] = false 
		check()

	elseif self.myBall8:hitTestPoint(x, y) and conf.wallet >= conf.price[7] and conf.pricesText[7] == true then
		print("select camera lense")
		conf.ballImage = "images/cameralense.png"
		conf.wallet = conf.wallet - conf.price[7]
		conf.priceText[7]:setVisible(false)
		self.walletText:setText("$"..conf.wallet)
		conf.pricesText[7] = false 
		check()
	
	elseif self.myBall8:hitTestPoint(x, y) and conf.pricesText[7] == false then 
		print("select camera lense")
		conf.ballImage = "images/cameralense.png"
		self.walletText:setText("$"..conf.wallet)
		conf.pricesText[7] = false 
		check()

	elseif homeButton:hitTestPoint(x, y) then 
		event:stopPropagation()
		sceneManager:changeScene("begin", conf.transitionTime * 2, conf.transition, conf.easing)
	end 
end