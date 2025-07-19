--!strict
local Filled = require('@self/Filled')
local Nonfilled = require('@self/Nonfilled')
local Loader = require('@self/Loader')

local Icons = {
	['Filled'] = Filled,
	['Nonfilled'] = Nonfilled
}

return function(key : Enum.KeyCode | Enum.UserInputType, Type : 'Filled' | 'Nonfilled') : string
	local keyName = key.Name
	local icon = Icons[Type][keyName]
	
	if icon ~= nil then
		Loader({icon})
	end
	
	return icon
end