require "box2d"

brick = Core.class(Sprite)

function brick:init(world, x, y)
	local brick = Bitmap.new(Texture.new("images/./brick.jpg"))
	brick:setAnchorPoint(0.5,0.5)
	
	self:addChild(brick)
	
	local body = world:createBody{type = b2.DYNAMIC_BODY}
	body:setPosition(x, y)
	body:setAngle(brick:getRotation() * math.pi/180)
	local poly = b2.PolygonShape.new()
	poly:setAsBox(brick:getWidth()/2, brick:getHeight()/2)
	body:createFixture{shape = poly, density = 1.2, friction = 0.5, restitution = 0.4}
	
	self.body = body
	self.body.type = "brick"
end
