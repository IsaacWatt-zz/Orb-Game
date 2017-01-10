require "box2d"

wood = Core.class(Sprite)

function wood:init(world, x, y)
	local wood = Bitmap.new(Texture.new("images/logImage.png"))
	wood:setAnchorPoint(0.5,0.5)
	wood:setScale(.08)
	self:addChild(wood)
	
	local body = world:createBody{type = b2.DYNAMIC_BODY}
	body:setPosition(x, y)
	body:setAngle(wood:getRotation() * math.pi/180)
	local poly = b2.PolygonShape.new()
	poly:setAsBox(wood:getWidth()/2, wood:getHeight()/2)
	body:createFixture{shape = poly, density = 1.5, friction = .02, restitution = .4}
	
	self.body = body
	self.body.type = "wood"
	
	self.body.scaleFactor = 1
	self.body.changeScale = false
end

function wood:changeScale(world)
	local x, y = self.body:getPosition()
	local scaleFactor = self.body.scaleFactor 
	
	self:setScale(scaleFactor)
	world:destroyBody(self.body)
	
	local body = world:createBody{type = b2.DYNAMIC_BODY}
	body:setPosition(x, y)
	body:setAngle(self:getRotation() * math.pi/180)
	local poly = b2.PolygonShape.new()
	poly:setAsBox(self:getWidth()/2, self:getHeight()/2)
	body:createFixture{shape = poly, density = 1.0, friction = .01, restitution = .4}
	
	self.body = body
	self.body.type = "wood"
	
	self.body.scaleFactor = scaleFactor
	self.body.changeScale = false
end 



