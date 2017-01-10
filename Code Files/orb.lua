require "box2d" 

orb = Core.class(Sprite)

function orb:init(world, x, y, img, value)

	local orb = Bitmap.new(Texture.new(img))

	orb:setAnchorPoint(0.5,0.5)
	orb:setScale(0.05)
	
	local radius = orb:getWidth()/2 
	self:addChild(orb)
	local body = world:createBody{type = b2.DYNAMIC_BODY}
	body:setPosition(x,y)
	body:setAngle(orb:getRotation() * math.pi/180)
	local circle = b2.CircleShape.new(0, 0, radius)
	local fixture = body:createFixture{shape = circle, density = 5, 
	friction =  0.5, restitution = 0.3}
	
	self.body = body
	self.body.type = "orb"
	self.body.value = value 
	self.body.scalefactor = 1
	self.body.changescale = false
end



function orb:changescale(world)
	local x, y = self.body:getPosition()
	local radius = self:getWidth() /4
	local scalefactor = self.body.scalefactor 
	
	self:setScale(scalefactor)
	
	world:destroyBody(self.body)

	local body = world:createBody{type = b2.DYNAMIC_BODY}
	body:setPosition(x,y)
	body:setAngle(self:getRotation() * math.pi/180)
	local circle = b2.CircleShape.new(0, 0, radius )
	local fixture = body:createFixture{shape = circle, density = 5, 
	friction =  0.5, restitution = 0.3}
	
	self.body = body
	self.body.type = "orb"
	self.body.value = 0
	self.body.scalefactor = scalefactor
	self.body.changescale = false
end 






