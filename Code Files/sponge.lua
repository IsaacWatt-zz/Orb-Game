require "box2d"
sponge = Core.class(Sprite)

function sponge:init(world, x, y, scale)
	local sponge = Bitmap.new(Texture.new("images/./sponge.png"))
	sponge:setAnchorPoint(0.5,0.5)
	
	sponge:setScale(scale)
	
	self:addChild(sponge)

	local body = world:createBody{type = b2.DYNAMIC_BODY}
	body:setPosition(x, y)
	body:setAngle(sponge:getRotation() * math.pi/180)
	local poly = b2.PolygonShape.new()
	poly:setAsBox(sponge:getWidth()/2, sponge:getHeight()/2)
	body:createFixture{shape = poly, density = 10000000000, friction = 10000, restitution = 2}
	
	self.body = body
	self.body.type = "sponge"
end