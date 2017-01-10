require "box2d"

ball = Core.class(Sprite)

function ball:init(world, x, y,img)
	
	local ballimg = Bitmap.new(Texture.new(img))
	ballimg:setAnchorPoint(0.5,0.5)
	ballimg:setScale(0.11)
	
	local radius = ballimg:getWidth()/2

	self:addChild(ballimg)
	
	local body = world:createBody{type = b2.DYNAMIC_BODY}
	body:setPosition(x, y)
	body:setAngle(ballimg:getRotation() * math.pi/180)
	local circle = b2.CircleShape.new(0, 0, radius)
	body:createFixture{shape = circle, density = 1.0, friction = 0.1, restitution = 0.8}

	self.body = body
	self.body.type = "ball"
end


