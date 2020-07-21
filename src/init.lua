-- OptimisticSide

local tweenService = game:GetService("TweenService")
local soundService = game:GetService("SoundService")

local SoundStablizer = {}
SoundStablizer.historyBuffer = {}
SoundStablizer.__index = SoundStablizer


function SoundStablizer:update()
	local currentVolume = self:getVolume()
	self.loudestVolume = math.max(self.loudestVolume, currentVolume)
	self.historyBuffer[#self.historyBuffer+1] = currentVolume
	
	if currentVolume > self.maxVolume then
		local newVolume = math.max(self.sound.Volume * (math.min(currentVolume, self.maxVolume) / 1000), 0.01)
		self:setVolume(newVolume,  ((currentVolume) - newVolume) / 100)
	end
end

function SoundStablizer:getVolume()
	return self.sound.PlaybackLoudness * self.sound.Volume
end

function SoundStablizer:setVolume(volume, speed)
	local stablizerTween = tweenService:Create(self.sound, TweenInfo.new(speed), {
		Volume = volume;
	})
	stablizerTween:Play()
	return stablizerTween
end

function SoundStablizer:getDecibals(rootMeanSquare)
	rootMeanSquare = rootMeanSquare or self.sound.PlaybackLoudness
	return 20 * math.log10(0.001 * rootMeanSquare)
end

function SoundStablizer:getRootMeanSquare(decibals)
	local rootMeanSquare = 10 ^ (decibals / 20)
	return rootMeanSquare
end


function SoundStablizer.new(sound, maxVolume)
	local self = setmetatable({}, SoundStablizer)
	
	self.historyBuffer = {}
	self.loudestVolume = 0
	self.maxVolume = maxVolume or 350
	self.sound = sound
	
	return self
end


return SoundStablizer
