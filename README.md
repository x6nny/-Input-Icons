# 🕹️ Input Icons
Easily get icons for user inputs!

# Features
- Filled Icons
- Outlined Icons
- Preloading

# Marketplace Model
[🕹️ Input Icons](https://create.roblox.com/store/asset/111910627605477/Input-Icons)

# Manual Install
Run in console in studio
```lua
local Location = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local ScriptEditorService = game:GetService("ScriptEditorService")

HttpService.HttpEnabled = true

local RepositoryName = "x6nny/-Input-Icons"
local Branch = "main"
local Repository = HttpService:JSONDecode(HttpService:GetAsync(`https://api.github.com/repos/{RepositoryName}/git/trees/{Branch}?recursive=1`)).tree
local RawUrl = `https://raw.githubusercontent.com/{RepositoryName}/main/`

local Storage = game:GetService('ReplicatedStorage')

local Directory

local function build (path, index)
	local result: string = path[index]

	if not result then return end

	if result:find(".luau") then
		local instance_type = Instance.new("ModuleScript")
		instance_type.Name = result

		if Directory and result:find("init.") then
			local copy = Directory:Clone()

			for _, item in copy:GetChildren() do
				item.Parent = instance_type
			end

			instance_type.Name = Directory.Name
			instance_type.Parent = Directory.Parent
			copy:Remove()
			Directory:Remove()
		else
			instance_type.Name = instance_type.Name:gsub(".luau", "")
			instance_type.Parent = Directory
		end

		local rebuilt = ""

		for _, item in path do
			rebuilt = rebuilt .. `{item}/`
		end

		local result = HttpService:GetAsync(RawUrl..rebuilt:sub(1, -2))

		ScriptEditorService:UpdateSourceAsync(instance_type, function()
			return result
		end)

	elseif result then
		local instance_type = (Storage:FindFirstChild(result) or Instance.new("Folder"))
		instance_type.Name = result
		instance_type.Parent = Storage
		Directory = instance_type
	end

	local next = index + 1	
	build(path, next)
end

for _, item in Repository do
	local paths = item.path:split("/")
	build(paths, 1)
end
```

# Usage
```lua
local Key_E_Icon = InputIcons(Enum.KeyCode.E, 'Filled')
local Button_1_Icon = InputIcons(Enum.UserInputType.MouseButton1, 'Nonfilled')
```
