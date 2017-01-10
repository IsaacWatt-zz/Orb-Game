
StartScene = Core.class(Sprite)

function StartScene:init()	

	homeButton = Bitmap.new(Texture.new("images/homebutton.png"))
	homeButton:setScale(.04)
	homeButton:setPosition(7, 33)
	self:addChild(homeButton)

	sceneButton = {}
	for i = 1, 9 do 
		sceneButton[i] = Bitmap.new(Texture.new("images/blank.png"))
		sceneButton[i]:setScale(.06)
		self:addChild(sceneButton[i])
	end 
	
	sceneButton[1]:setPosition( (conf.maxx/2-sceneButton[1]:getWidth()/2) /4 + 20 , 20)
	sceneButton[4]:setPosition((conf.maxx/2-sceneButton[2]:getWidth()/2) / 4 + 20, conf.maxy/2-sceneButton[2]:getHeight()/2)
	sceneButton[7]:setPosition((conf.maxx/2-sceneButton[3]:getWidth()/2) / 4 + 20, conf.maxy-sceneButton[3]:getHeight()-20)
	
	------
	
	sceneButton[2]:setPosition(conf.maxx/2-sceneButton[1]:getWidth()/2, 20)
	sceneButton[5]:setPosition(conf.maxx/2-sceneButton[2]:getWidth()/2, conf.maxy/2-sceneButton[2]:getHeight()/2)
	sceneButton[8]:setPosition(conf.maxx/2-sceneButton[3]:getWidth()/2, conf.maxy-sceneButton[3]:getHeight()-20)
	
	------
	
	sceneButton[3]:setPosition((conf.maxx/2-sceneButton[1]:getWidth()/2) * 1.65, 20)
	sceneButton[6]:setPosition((conf.maxx/2-sceneButton[2]:getWidth()/2) * 1.65, conf.maxy/2-sceneButton[2]:getHeight()/2)
	sceneButton[9]:setPosition((conf.maxx/2-sceneButton[3]:getWidth()/2) * 1.65, conf.maxy-sceneButton[3]:getHeight()-20)
	
	numberText = {}
	for i = 1, 9 do 

		numberText[i] = TextField.new(nil, i) 
		numberText[i]:setScale(3)
		self:addChild(numberText[i])
		numberText[i]:setVisible(false)
	end 

	local lockimg = {}
	for i = 1, 9 do
		lockimg[i] = Bitmap.new(Texture.new("images/lock.png"))
		lockimg[i]:setScale(0.2, 0.2)
		self:addChild(lockimg[i])
		lockimg[i]:setVisible(false)
		
	end 
	
	lockimg[1]:setPosition((conf.maxx/2- lockimg[1]:getWidth()/2) /4 + 5 , 15)
	lockimg[2]:setPosition(conf.maxx/2-lockimg[1]:getWidth()/2 , 15)
	lockimg[3]:setPosition((conf.maxx/2-lockimg[1]:getWidth()/2) + 130, 15)
	
	lockimg[4]:setPosition((conf.maxx/2- lockimg[2]:getWidth()/2) / 4 + 5, conf.maxy/2-lockimg[2]:getHeight()/2)
	lockimg[5]:setPosition(conf.maxx/2-lockimg[2]:getWidth()/2, conf.maxy/2-lockimg[2]:getHeight()/2)
	lockimg[6]:setPosition((conf.maxx/2-lockimg[2]:getWidth()/2) + 130, conf.maxy/2-lockimg[2]:getHeight()/2)
	
	lockimg[7]:setPosition((conf.maxx/2-lockimg[3]:getWidth()/2) / 4 + 5, conf.maxy-lockimg[3]:getHeight()-15)
	lockimg[8]:setPosition(conf.maxx/2-lockimg[3]:getWidth()/2, conf.maxy-lockimg[3]:getHeight()-15)
	lockimg[9]:setPosition((conf.maxx/2-lockimg[3]:getWidth()/2) + 130, conf.maxy-lockimg[3]:getHeight()-15)
	
	-----
	numberText[1]:setPosition( (conf.maxx/2-numberText[1]:getWidth()/2) /4 + 45,70 )
	numberText[2]:setPosition( (conf.maxx/2-numberText[1]:getWidth()/2) /4 + 173,70 )
	numberText[3]:setPosition( (conf.maxx/2-numberText[1]:getWidth()/2) /4 + 303,70 )
	-- 
	numberText[4]:setPosition( (conf.maxx/2-numberText[1]:getWidth()/2) /4 + 43,172 )
	numberText[5]:setPosition( (conf.maxx/2-numberText[1]:getWidth()/2) /4 + 173,172 )
	numberText[6]:setPosition( (conf.maxx/2-numberText[1]:getWidth()/2) /4 + 303,172 ) 
	--
	numberText[7]:setPosition( (conf.maxx/2-numberText[1]:getWidth()/2) /4 + 43,270 )
	numberText[8]:setPosition( (conf.maxx/2-numberText[1]:getWidth()/2) /4 + 173,270 )
	numberText[9]:setPosition( (conf.maxx/2-numberText[1]:getWidth()/2) /4 + 303,270 )

	self:addEventListener(Event.MOUSE_DOWN, self.btnClick, self)

	onLevel = {}

	for i = 1, 9 do 
		if conf.onLevel >= i then 
		numberText[i]:setVisible(true)
		end
	end 


	for i = 1, 9 do 
     
		if conf.onLevel < i  then 
			lockimg[i]:setVisible(true)
		else 
			lockimg[i]:setVisible(false)
		end 
	end 

end 

function StartScene:btnClick(event)
	local x = event.x
	local y = event.y
	
	for i = 1, 9 do 
		if sceneButton[i]:hitTestPoint(x, y) and numberText[i]:isVisible() then	
			event:stopPropagation()
			sceneManager:changeScene("level"..i, conf.transitionTime, conf.transition, conf.easing)
		end 
	end 
	
	if homeButton:hitTestPoint(x, y) then 
		event:stopPropagation()
		sceneManager:changeScene("begin", conf.transitionTime, conf.transition, conf.easing)
	end 

end 
	

