
# Sound Stablizer
A simple audio stablizer for use on the ROBLOX platform, to prevent audios from getting too loud.

### Usage
Requiring the module will simply return the `SoundStablizer` class, from which an object can be constructed with the `new` method.
```lua
local SoundStablizer = require(script.SoundStablizer)
local sound = workspace.Sound

local stablizer = SoundStablizer.new(sound)
```
From there, there is one main method that will be used. This is the `update` method, which will update the sound's volume.
```lua
local runService = game:GetService("RunService")

runService.RenderStepped:Connect(function()
    stablizer:update()
end)
```
