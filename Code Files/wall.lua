--include box2d library
require "box2d"

wall = Core.class(Sprite)

function wall:init(world, x, y, width, height, colour, angle)
	local wallshp = Shape.new()
	colour = 0x000000

	wallshp:setFillStyle(Shape.SOLID, colour, 1)
	wallshp:beginPath()
	
	wallshp:moveTo(-width/2,-height/2)
	wallshp:lineTo(width/2, -height/2)
	wallshp:lineTo(width/2, height/2)
	wallshp:lineTo(-width/2, height/2)
	wallshp:closePath()
	wallshp:endPath()

	self:addChild(wallshp)
	
	local body = world:createBody{type = b2.STATIC_BODY}
	body:setPosition(x, y)
	body:setAngle(angle * math.pi/180)
	
	local poly = b2.PolygonShape.new()
	poly:setAsBox(wallshp:getWidth()/2, wallshp:getHeight()/2)
	body:createFixture{shape = poly, density = 1.0, friction = 0.1, restitution = 0}

	self.body = body
	self.body.type = "wall"

end
