require "box2d"
ice = Core.class(Sprite)

function ice:init(world, x, y, scale, xScale, yScale)

	local ice = Bitmap.new(Texture.new("images/ice.png"))
	ice:setAnchorPoint(0.5,0.5)
	
	local ice1 = Bitmap.new(Texture.new("images/crackedice.png"))
	ice1:setAnchorPoint(0.5,0.5)
	
	local ice2 = Bitmap.new(Texture.new("images/crackedice2.png"))
	ice2:setAnchorPoint(0.5,0.5)
	
	local ice3 = Bitmap.new(Texture.new("images/crackedice3.png"))
	ice3:setAnchorPoint(0.5,0.5)
	
	self:addChild(ice)
	self:addChild(ice1)
	self:addChild(ice2)
	self:addChild(ice3)
	
	ice:setScale(scale) 
	ice:setScaleX(xScale)
	ice:setScaleY(yScale)
	
	ice1:setScale(scale) 
	ice1:setScaleX(xScale)
	ice1:setScaleY(yScale)
	
	ice2:setScale(scale) 
	ice2:setScaleX(xScale)
	ice2:setScaleY(yScale)
	
	ice3:setScale(scale) 
	ice3:setScaleX(xScale)
	ice3:setScaleY(yScale)
	
	local body = world:createBody{type = b2.DYNAMIC_BODY}
	body:setPosition(x, y)
	
	body:setAngle(ice:getRotation() * math.pi/180)
	local poly = b2.PolygonShape.new()
	poly:setAsBox(ice:getWidth()/2, ice:getHeight()/2)
	body:createFixture{shape = poly, density = 0.5, 
	friction = 0.01, restitution = 0.3}

	self.body = body
	self.body.type = "ice"
	self.body.strength = 100
	
end

function ice:updateSprite()
	if self.body.strength == 100 then
		self:getChildAt(1):setVisible(true)
		self:getChildAt(2):setVisible(false)
		self:getChildAt(3):setVisible(false)
		self:getChildAt(4):setVisible(false)
	elseif self.body.strength == 90 then
		self:getChildAt(1):setVisible(false)
		self:getChildAt(2):setVisible(true)
		self:getChildAt(3):setVisible(false)
		self:getChildAt(4):setVisible(false)
	elseif self.body.strength == 80 then 
	
		self:getChildAt(1):setVisible(false)
		self:getChildAt(2):setVisible(false)
		self:getChildAt(3):setVisible(true)
		self:getChildAt(4):setVisible(false)
	elseif self.body.strength == 70 then  
		self:getChildAt(1):setVisible(false)
		self:getChildAt(2):setVisible(false)
		self:getChildAt(3):setVisible(false)
		self:getChildAt(4):setVisible(true)
	end
end


