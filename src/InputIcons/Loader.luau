--!strict
local ContentProvider = game:GetService('ContentProvider')

return function(Assets : {})
	pcall(ContentProvider.PreloadAsync, ContentProvider, Assets)
end