
sceneManager = SceneManager.new({
	["begin"] = BeginScene,
	["start"] = StartScene,
	["StoreScene"] = StoreScene, 
	["level1"] = level1,
	["level2"] = level2,
	["level3"] = level3,
	["level4"] = level4, 
	["level5"] = level5, 
})

stage:addChild(sceneManager)


for i = 1, 7 do 
conf.pricesText[i] = true 
end 

for i = 1, 8 do 
conf.price[i] = 60 * i
conf.priceText[i] = TextField.new(nil, "$"..conf.price[i]) 
conf.priceText[i]:setScale(2)
end 

sceneManager:changeScene("begin", conf.transitionTime, conf.transition, conf.easing)









