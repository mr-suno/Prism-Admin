--[[

   UI Copied from Infinite Yield

   Credits: Suno, programmer, UI designer (Sort of), everything else.

]]


local Get, Disabled = game.GetService, false

local Components = {
   ["Services"] = {
      ["TCS"] = Get(game, "TextChatService"),
      ["RS"] = Get(game, "ReplicatedStorage"),
      ["P"] = Get(game, "Players"),
      ["CG"] = Get(game, "CoreGui"),
      ["TP"] = Get(game, "TeleportService")
   },

   ["Configurations"] = {
      ["Prefix"] = ";",
      -- ["Aliases"] = {",", ".", "-", "="}
      ["Version"] = "1.0.0",
      ["Content-Type"] = "FE"
   }
}

local IsLegacy = Components.Services.TCS.ChatVersion == Enum.ChatVersion.LegacyChatService
local You = Components.Services.P.LocalPlayer

local Factor = "Prism Admin " .. Components.Configurations["Content-Type"] .. " v" .. Components.Configurations.Version

local function Chat(Message: string)
   if IsLegacy then
      Components.Services.RS:FindFirstChild("SayMessageRequest", true):FireServer(Message, "All")
   else
      local Channels = Components.Services.TCS:FindFirstChild("RBXGeneral", true)

      if Channels then
         Channels:SendAsync(Message)
      else
         Components.Services.TCS:WaitForChild("RBXGeneral", true):SendAsync(Message)
      end
   end
end

local function CreateNotification(Title: string, Content: string)

   for _, Container in ipairs(Components.Services.CG:GetChildren()) do if Container:IsA("ScreenGui") and string.find(Container.Name, "Prism") then for _, Expired in ipairs(Container:FindFirstChild("Folder"):GetChildren()) do if Expired:IsA("Frame") and string.find(Expired.Name, "Notification") then Expired:Destroy() end end end end

   local Notification = Instance.new("Frame", Components.Services.CG[Factor]:FindFirstChild("Folder")) do
      
      Notification.Size        = UDim2.new(0, 300, 0, 150)
      Notification.AnchorPoint = Vector2.new(0.5, 0.5)
      Notification.Position    = UDim2.new(0.5, 0, 0.5, 0)
      Notification.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
      Notification.ZIndex      = 2
      Notification.Name        = "Prism_Notification"

      local Header = Instance.new("TextLabel", Notification) do
          
         Header.Text           = Title
         Header.TextSize       = 18
         Header.FontFace       = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
         Header.TextColor3     = Color3.fromRGB(255, 255, 255)
         Header.TextXAlignment = Enum.TextXAlignment.Center
         Header.BackgroundTransparency = 0
         Header.BackgroundColor3 = Color3.fromRGB(36, 36, 37)
         Header.Size           = UDim2.new(1, 0, 0, 20)
         Header.ZIndex         = 3
         Header.RichText       = true

         local Close = Instance.new("ImageButton", Header) do
            
            Close.AnchorPoint  = Vector2.new(1, 0.5)
            Close.Position     = UDim2.new(1, -1, 0.5, 0)
            Close.Size         = UDim2.new(0, 16, 0, 16)
            Close.ZIndex       = 4
            Close.BackgroundTransparency = 1
            Close.MouseButton1Click:Connect(function()

               Notification:Destroy()

            end)

            local Icon = Instance.new("ImageLabel", Close) do
               
               Icon.AnchorPoint = Vector2.new(0.5, 0.5)
               Icon.Position    = UDim2.new(0.5, 0, 0.5, 0)
               Icon.Image       = "rbxassetid://5054663650"
               Icon.Size        = UDim2.new(0, 10, 0, 10)
               Icon.BackgroundTransparency = 1
               Icon.ZIndex      = 5

            end
         end
      end
      
      local Description = Instance.new("TextLabel", Notification) do
         
         Description.Text           = Content
         Description.TextSize       = 16
         Description.FontFace       = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
         Description.TextColor3     = Color3.fromRGB(255, 255, 255)
         Description.TextXAlignment = Enum.TextXAlignment.Left
         Description.TextYAlignment = Enum.TextYAlignment.Top
         Description.BackgroundTransparency = 1
         Description.Size           = UDim2.new(1, 0, 0, 130)
         Description.AnchorPoint    = Vector2.new(0, 1)
         Description.Position       = UDim2.new(0, 0, 1, 0)
         Description.ZIndex         = 3
         Description.TextWrapped    = true
         Description.RichText       = true
         Description.LineHeight     = 1.2

         local Padding = Instance.new("UIPadding", Description) do
            
            Padding.PaddingLeft   = UDim.new(0, 5)
            Padding.PaddingBottom = UDim.new(0, 5)
            Padding.PaddingRight  = UDim.new(0, 5)
            Padding.PaddingTop    = UDim.new(0, 5)

         end
      end
   end

end

--[[ Apologies for any messes, this is horrible ... ]]
--[[ Create our UI ]] do

   for _, Expired in ipairs(Components.Services.CG:GetChildren()) do if Expired:IsA("ScreenGui") and string.find(Expired.Name, "Prism") then Expired:Destroy() end end
   
   local Main = Instance.new("ScreenGui", Components.Services.CG)
   local Base = Instance.new("Frame",     Main) do
      
      Base.AnchorPoint = Vector2.new(1, 1)
      Base.Size        = UDim2.new(0, 250, 0, 220)
      Base.BackgroundTransparency = 0
      Base.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
      Base.Position    = UDim2.new(1, 0, 1, 0)
      Base.ZIndex      = 0

   end

   local Holder = Instance.new("Folder", Main) do end

   local Header = Instance.new("TextLabel", Base) do
      
      Header.Size      = UDim2.new(1, 0, 0, 20)
      Header.BackgroundTransparency = 0
      Header.BackgroundColor3 = Color3.fromRGB(36, 36, 37)
      Header.FontFace  = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
      Header.TextSize  = 18
      Header.TextXAlignment = Enum.TextXAlignment.Center
      Header.ZIndex    = 1
      Header.TextColor3 = Color3.fromRGB(255, 255, 255)
      
      local Information = Instance.new("ImageButton", Header) do
         
         Information.AnchorPoint = Vector2.new(1, 0.5)
         Information.BackgroundTransparency = 1
         Information.Image = "rbxassetid://3523243755"
         Information.Size  = UDim2.new(0, 16, 0, 16)
         Information.Position = UDim2.new(1, 0, 0.5, 0)
         Information.MouseButton1Click:Connect(function()
            
            CreateNotification("Prism's Inspiration", "This project was <b>heavily inspired</b> by Infinite Yield.\nThank you for the UI design.")

         end)
      end

   end

   local Commands = Instance.new("Frame", Base) do
      
      Commands.AnchorPoint = Vector2.new(0, 1)
      Commands.Position = UDim2.new(0, 0, 1, 0)
      Commands.BackgroundColor3 = Color3.fromRGB(36, 36, 37)
      Commands.BackgroundTransparency = 0
      Commands.ZIndex   = 1
      Commands.Size     = UDim2.new(1, 0, 0, 175)

      local Dictionary = Instance.new("ScrollingFrame", Commands) do
         
         Dictionary.AnchorPoint = Vector2.new(0.5, 0.5)
         Dictionary.Size        = UDim2.new(0.95, 0, 0.95, 0)
         Dictionary.Position    = UDim2.new(0.5, 0, 0.5, 0)
         -- Dictionary.ScrollBarThickness = 0
         Dictionary.BackgroundTransparency = 1
         Dictionary.AutomaticCanvasSize = Enum.AutomaticSize.Y
         Dictionary.CanvasSize  = UDim2.new(0, 0, 0, 0)

         local Layout = Instance.new("UIListLayout", Dictionary) do end

      end

   end

   Main.Name = Factor
   Header.Text = Main.Name
end

local ExecutedCommands = {}
local Commands, Aliases = {}, {}

local function Command(Alias, Callback)
   local Primary = Alias[1]

   if type(Primary) ~= "string" then
      return
   end

   if not Commands[Primary] then
      Commands[Primary] = {
         Callback = Callback,
         Aliases, Alias
      }

      local Path = Components.Services.CG[Factor].Frame.Frame.ScrollingFrame

      local New = Instance.new("TextButton", Path) do

         New.Size                   = UDim2.new(1, 0, 0, 20)
         New.BackgroundTransparency = 1
         New.BackgroundColor3       = Color3.fromRGB(36, 36, 37)
         New.FontFace               = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
         New.TextSize               = 18
         New.TextXAlignment         = Enum.TextXAlignment.Center
         New.ZIndex                 = 1
         New.Text                   = table.concat(Alias, " / ")
         New.TextColor3             = Color3.fromRGB(255, 255, 255)
         New.TextXAlignment         = Enum.TextXAlignment.Left
   
      end
   else
      return
   end

   for i = 2, #Alias do
      local Index = Alias[i]

      if type(Index) == "string" then
         if not Aliases[Index] then
            Aliases[Index] = Primary
         end
      end
   end
end

local function Handle(Input: string?)
   if not Disabled then
      if string.sub(Input, 1, #Components.Configurations.Prefix) == Components.Configurations.Prefix then
         local New = string.sub(Input, #Components.Configurations.Prefix + 1)
         local Arguments = {}
   
         for Arg in string.gmatch(New, "%S+") do
            table.insert(Arguments, Arg)
         end
   
         local Primary = Aliases[Arguments[1]] or Arguments[1]
         local Callback = Commands[Primary]
   
         if ExecutedCommands[Primary] then
            return
         end
   
         if Callback then
            ExecutedCommands[Primary] = true
            Callback.Callback(unpack(Arguments))
   
            ExecutedCommands[Primary] = nil
         end
      end
   end
end

if IsLegacy then
   local function OnChatted(Message: string)
      Handle(Message)
   end

   You.Chatted:Connect(OnChatted)
else
   Components.Services.TCS.MessageReceived:Connect(function(TCM: TextChatMessage)
      if tostring(TCM.TextSource) == You.Name then
         Handle(TCM.Text)
      end
   end)
end

local function FindPlayer(Target: string)
   if not Target then
      return
   end

   local Saved = {}

   for _, Player in ipairs(Components.Services.P:GetPlayers()) do
      if string.lower(Player.Name):match(string.lower(Target)) or string.lower(Player.DisplayName):match(string.lower(Target)) then
         table.insert(Saved, Player)
      end
   end

   if #Saved > 0 then
      return Saved[1]
   elseif #Saved < 1 then
      return nil
   end
end

--[[ Add Basic Commands ]] do
   
   Command({ "test", "example", "working" }, function()
      CreateNotification("Working", "Commands are working exactly how they should be!")
   end)

   Command({ "dex", "newdex", "explorer" }, function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/DarkNetworks/Infinite-Yield/main/dex.lua"))()
   end)

   Command({ "rj", "rejoin", "rej", "rjoin" }, function()
      Components.Services.TP:TeleportToPlaceInstance(game.PlaceId, game.JobId, You)
   end)

   Command({ "goto", "to", "tpto" }, function(...)
      local Arguments = {...}
      table.remove(Arguments, 1)
      
      local Target = FindPlayer(table.concat(Arguments, " "))
      
      You.Character:FindFirstChild("HumanoidRootPart").CFrame = Get(game, "Players")[Target.Name].Character:FindFirstChild("HumanoidRootPart").CFrame * CFrame.new(1.5, 0, 2)
   end)

   Command({ "rspy", "remotespy" }, function()
      if hookfunction and hookmetamethod then
         loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/78n/SimpleSpy/main/SimpleSpyBeta.lua"))()
      else
         CreateNotification("Unsupported Command", "Your exploit does not meet the requirements to run this command.\nMissing: <b>hookfunction</b>, <b>hookmetamethod</b>")
      end
   end)

   Command({ "ws", "speed", "walkspeed" }, function(...)
      local Arguments = {...}
      tabel.remove(Arguments, 1)

      local Amount = tonumber(table.concat(Arguments, " "))

      You.Character:FindFirstChild("Humanoid").WalkSpeed = Amount
   end)

   Command({ "reload", "relaunch", "restart" }, function()
      CreateNotification("Please wait...", "The script is attempting to relaunch.\nThis should take at most a few seconds.")
      Disabled = true

      task.wait(0.25)
      Get(game, "CoreGui")[Factor]:Destroy()

      loadstring(game:HttpGet(
         "https://github.com/mr-suno/Prism-Admin/blob/main/main.lua?raw=true"
      ))()
   end)

end

Chat("[+] loaded")
