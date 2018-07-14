# Orb-Game
Orb Game is a physics based game in which the user proceeds through a series of levels. 
Using X and Y components of the orbs velocity, one must arch their orb to hit three different objects. 
Points are awarded for doing so, which can be used to obtain different themed orbs.

<table align="center">
    <tr>
        <td>
            <img src="https://github.com/IsaacWatt/Orb-Game/blob/master/docs/levels.jpg" width="250px">
        </td>
        <td>
            <img src="https://github.com/IsaacWatt/Orb-Game/blob/master/docs/menu.jpg" width="250px">
        </td>
        <td>
            <img src="https://github.com/IsaacWatt/Orb-Game/blob/master/docs/shop.jpg" width="250px">
        </td>
    </tr>
</table>

## Table of Contents

- [Gameplay](#gameplay)
	- [Pseudo Gameplay](#pseudo-gameplay)
	- [Sample Gameplay](#sample-gameplay)

- [Features](#features)
    - [The Shop](#the-shop)
    - [Obstacles](#obstacles)
    
- [How to run Orb Game](#how-to-run-orb-game)

### Gameplay

#### Pseudo Gameplay

When in a level launch the orb by pressing the play button. Once this has been pressed, the orb must be recalibrated by pressing the pause button. You must alternate between these two buttons when playing. To adjust your x velocity, simply press the up and down arrows above "x power" to do so. Similarly, to adjust your y velocity simply adjust the up and down arrows above "y power". When you have completed the stage, the stage will fade out and you will unlock the next stage. If you choose to quit early, simply press the home button. The initial configuration object is as follows: 
```lua
conf = {
	transition = SceneManager.fade,
	transitionTime = 1.3,
	easing = easing.outBack,
	maxx = application:getContentWidth(),
	maxy = application:getContentHeight(),
	onLevel = 1,
	ballImage = "images/circle.png",
	wallet = 60,
	
	pricesText = {}, 		
	priceText = {},
	price = {},
}
```
Thus, a user will begin on level 1, with 60$ of in game currency. 

#### Sample Gameplay

<table align="center">
    <tr>
        <td>
            <video src="https://github.com/IsaacWatt/Orb-Game/blob/master/docs/gameplay1.mp4" width="320" height="200" controls preload></video>
        </td>
        <td>
            <img src="" width="250px">
        </td>
        <td>
            <img src="" width="250px">
        </td>
    </tr>
</table>

### Features

#### The Shop
Every time you complete a stage, you are awarded with $60 in game currency. This in game currency can be spent at the shop, which is found on the home screen. Here you are able to purchase differently themes orbs and use them as you proceed through the levels! 

#### Obstacles 
Orb Game implements differently created obsticles each with different properties and side effects. Each object is created with a `createFixture` object which defines properties of each body. The following obsticle types have been implemented: 

```
Brick
Sponge
Logs
Ice 
```

Each obsticle is created with a constructor that looks as follows, this specific example highlights the `createFixture` for a `brick`. 
```lua
function brick:init(world, x, y)
    -- add child to scene
    -- create body
    
    body:createFixture{shape = poly, density = 1.2, friction = 0.5, restitution = 0.4}
    self.body = body
    self.body.type = "brick"
end 
```
A brick is made to be more dense than an orb, thus it is more resistant to a change in position and will not move as easily if it is hit. 

The `sponge` fixture creates an obsticle with a high density and friction to ensure it cannot be pushed around, along with a restitution such that if the orb touches the sponge, the orb will bounce off of it. 

The `log` constructor implements a `changeScale` function, that is called when the `log` is touched. Thus each time the orb hits a `log`, it will grow in size. This looks as follows: 
```lua
function wood:changeScale(world)
	local x, y = self.body:getPosition()
	local scaleFactor = self.body.scaleFactor 
	
	self:setScale(scaleFactor)
	world:destroyBody(self.body)
	
    -- create dynamic body and set fixture 
	
	self.body = body
	self.body.type = "wood"
	
	self.body.scaleFactor = scaleFactor
	self.body.changeScale = false 
end 
```

The `ice` constructor uses a function called `updateSprite` which allows the ice to crack when it is hit. Ice has a low friction value in its fixture which looks as follows: 
`body:createFixture{shape = poly, density = 0.5, friction = 0.01, restitution = 0.3}`. 
When the Orb hits an ice obsticle, the img property of the ice will be replaced with a slightly more cracked version of the ice img. This happens each time the ice is hit. 

### How to run Orb Game
To run the orb game, download the [Gideros Package](https://github.com/gideros/gideros/releases) (you will need Gideros Studio and the Gideros Player). Then run the `Box2DEx1.gproj` executable. From here you can open the Gideros Player, and hit run. 
Orb Game was intended to be played in landscape mode, so for the best experience set the gideros player's orientation to "Landscape Left". Orb Game has been tested up to Version `2018.6.2`. 
