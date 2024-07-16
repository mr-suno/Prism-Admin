--[[

   UI Copied from Infinite Yield

   Infinite Yield UI completely rewritten, except it's legible this time.

   -- -- --

   Credits: Suno, programmer, UI designer (Sort of), everything else.

]]


local Get, Disabled = game.GetService, false

local Components = {
   ["Services"] = {
      ["TCS"] = Get(game, "TextChatService"),
      ["RS"] = Get(game, "ReplicatedStorage"),
      ["P"] = Get(game, "Players"),
      ["CG"] = Get(game, "CoreGui"),
      ["TP"] = Get(game, "TeleportService"),
      ["UIS"] = Get(game, "UserInputService"),
      ["RUS"] = Get(game, "RunService")
   },

   ["Configurations"] = {
      ["Prefix"] = ";",
      -- ["Aliases"] = {",", ".", "-", "="}
      ["Version"] = "1.0.1",
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

local function CreateSidenote(Header: string, Content: string)

   for _, Container in ipairs(Components.Services.CG:GetChildren()) do if Container:IsA("ScreenGui") and string.find(Container.Name, "Prism") then for _, Expired in ipairs(Container:FindFirstChild("Folder"):GetChildren()) do if Expired:IsA("Frame") and string.find(Expired.Name, "Note") then Expired:Destroy() end end end end

   local Note = Instance.new("Frame", Components.Services.CG[Factor]:FindFirstChild("Folder")) do
      
      Note.Size                   = UDim2.new(0, 250, 0, 100)
      Note.Position               = UDim2.new(1, -500, 1, -100) -- Open is: 1, -500, 1, -100
      Note.BackgroundColor3       = Color3.fromRGB(36, 36, 37)
      Note.BackgroundTransparency = 0
      Note.ZIndex                 = 10
      Note.BorderSizePixel        = 0

      local Title = Instance.new("TextLabel", Note) do
         
         Title.BackgroundTransparency = 0
         Title.BackgroundColor3       = Color3.fromRGB(46, 46, 47)
         Title.Size                   = UDim2.new(1, 0, 0, 20)
         Title.ZIndex                 = 10
         Title.Text                   = Header
         Title.FontFace               = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
         Title.TextColor3             = Color3.fromRGB(255, 255, 255)
         Title.TextSize               = 14
         Title.RichText               = true
         Title.BorderSizePixel        = 0

      end

      local Description = Instance.new("TextLabel", Note) do
         
         Description.BackgroundTransparency = 1
         Description.BackgroundColor3       = Color3.fromRGB(46, 46, 47)
         Description.Size                   = UDim2.new(1, 0, 0, 75)
         Description.Position               = UDim2.new(0, 5, 0, 25)
         Description.ZIndex                 = 10
         Description.Text                   = Content
         Description.FontFace               = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
         Description.TextColor3             = Color3.fromRGB(255, 255, 255)
         Description.TextSize               = 16
         Description.LineHeight             = 1.2
         Description.RichText               = true
         Description.TextWrapped            = true
         Description.BorderSizePixel        = 0
         Description.ClipsDescendants       = true

         local Padding = Instance.new("UIPadding", Description) do
            
            Padding.PaddingRight = UDim.new(0, 15)
            Padding.PaddingLeft  = UDim.new(0, 8)

         end

      end

      local Close = Instance.new("TextButton", Note) do
         
         Close.BackgroundTransparency = 1
         Close.Size                   = UDim2.new(0, 20, 0, 20)
         Close.Position               = UDim2.new(1, -20, 0, 0)
         Close.ZIndex                 = 10
         Close.TextTransparency       = 1
         Close.BorderSizePixel        = 0

         local Icon = Instance.new("ImageLabel", Close) do
            
            Icon.AnchorPoint            = Vector2.new(0.5, 0.5)
            Icon.Image                  = "rbxassetid://5054663650"
            Icon.Size                   = UDim2.new(0, 10, 0, 10)
            Icon.Position               = UDim2.new(0.5, 0, 0.5, 0)
            Icon.BackgroundTransparency = 1
            Icon.ZIndex                 = 10
            Icon.BorderSizePixel        = 0

         end

         Close.MouseButton1Click:Connect(function()
            Note.Position = UDim2.new(1, -500, 1, 0)
         end)
      end
   end

   task.spawn(function()
      task.wait(3)

      Note.Position = UDim2.new(1, -500, 1, 0)
   end)

end

local function CreateNotification(Title: string, Content: string)

   for _, Container in ipairs(Components.Services.CG:GetChildren()) do if Container:IsA("ScreenGui") and string.find(Container.Name, "Prism") then for _, Expired in ipairs(Container:FindFirstChild("Folder"):GetChildren()) do if Expired:IsA("Frame") and string.find(Expired.Name, "Notification") then Expired:Destroy() end end end end

   local Notification = Instance.new("Frame", Components.Services.CG[Factor]:FindFirstChild("Folder")) do
      
      Notification.Size             = UDim2.new(0, 300, 0, 150)
      Notification.AnchorPoint      = Vector2.new(0.5, 0.5)
      Notification.Position         = UDim2.new(0.5, 0, 0.5, 0)
      Notification.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
      Notification.ZIndex           = 2
      Notification.Name             = "Prism_Notification"
      Notification.BorderSizePixel  = 0

      local Header = Instance.new("TextLabel", Notification) do
          
         Header.Text                   = Title
         Header.TextSize               = 18
         Header.FontFace               = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
         Header.TextColor3             = Color3.fromRGB(255, 255, 255)
         Header.TextXAlignment         = Enum.TextXAlignment.Center
         Header.BackgroundTransparency = 0
         Header.BackgroundColor3       = Color3.fromRGB(36, 36, 37)
         Header.Size                   = UDim2.new(1, 0, 0, 20)
         Header.ZIndex                 = 3
         Header.RichText               = true
         Header.BorderSizePixel        = 0

         local Close = Instance.new("ImageButton", Header) do
            
            Close.AnchorPoint            = Vector2.new(1, 0.5)
            Close.Position               = UDim2.new(1, -1, 0.5, 0)
            Close.Size                   = UDim2.new(0, 16, 0, 16)
            Close.ZIndex                 = 4
            Close.BackgroundTransparency = 1
            Close.BorderSizePixel        = 0
            Close.MouseButton1Click:Connect(function()

               Notification:Destroy()

            end)

            local Icon = Instance.new("ImageLabel", Close) do
               
               Icon.AnchorPoint            = Vector2.new(0.5, 0.5)
               Icon.Position               = UDim2.new(0.5, 0, 0.5, 0)
               Icon.Image                  = "rbxassetid://5054663650"
               Icon.Size                   = UDim2.new(0, 10, 0, 10)
               Icon.BackgroundTransparency = 1
               Icon.ZIndex                 = 5
               Icon.BorderSizePixel        = 0

            end
         end
      end
      
      local Description = Instance.new("TextLabel", Notification) do
         
         Description.Text                   = Content
         Description.TextSize               = 16
         Description.FontFace               = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
         Description.TextColor3             = Color3.fromRGB(255, 255, 255)
         Description.TextXAlignment         = Enum.TextXAlignment.Left
         Description.TextYAlignment         = Enum.TextYAlignment.Top
         Description.BackgroundTransparency = 1
         Description.Size                   = UDim2.new(1, 0, 0, 130)
         Description.AnchorPoint            = Vector2.new(0, 1)
         Description.Position               = UDim2.new(0, 0, 1, 0)
         Description.ZIndex                 = 3
         Description.TextWrapped            = true
         Description.RichText               = true
         Description.LineHeight             = 1.2
         Description.BorderSizePixel        = 0

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

   for _, Expired in ipairs(Components.Services.CG:GetChildren()) do if Expired:IsA("ScreenGui") and string.find(Expired.Name, "Prism") then Disabled = true Expired:Destroy() end end
   
   local Main = Instance.new("ScreenGui", Components.Services.CG)
   local Base = Instance.new("Frame",     Main) do
      
      Base.AnchorPoint            = Vector2.new(1, 1)
      Base.Size                   = UDim2.new(0, 250, 0, 220)
      Base.BackgroundTransparency = 0
      Base.BackgroundColor3       = Color3.fromRGB(46, 46, 47)
      Base.Position               = UDim2.new(1, 0, 1, 0)
      Base.ZIndex                 = 0
      Base.BorderSizePixel        = 0

   end

   local Holder = Instance.new("Folder", Main) do end

   local Header = Instance.new("TextLabel", Base) do
      
      Header.Size                   = UDim2.new(1, 0, 0, 20)
      Header.BackgroundTransparency = 0
      Header.BackgroundColor3       = Color3.fromRGB(36, 36, 37)
      Header.FontFace               = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
      Header.TextSize               = 18
      Header.TextXAlignment         = Enum.TextXAlignment.Center
      Header.ZIndex                 = 1
      Header.TextColor3             = Color3.fromRGB(255, 255, 255)
      Header.BorderSizePixel        = 0
      
      local Information = Instance.new("ImageButton", Header) do
         
         Information.AnchorPoint            = Vector2.new(1, 0.5)
         Information.BackgroundTransparency = 1
         Information.Image                  = "rbxassetid://3523243755"
         Information.Size                   = UDim2.new(0, 16, 0, 16)
         Information.Position               = UDim2.new(1, 0, 0.5, 0)
         Information.BorderSizePixel        = 0
         Information.MouseButton1Click:Connect(function()
            
            CreateNotification("Prism's Inspiration", "This project was <b>heavily inspired</b> by Infinite Yield.\nThank you for the UI design.")

         end)
      end

   end

   local Bar = Instance.new("Frame", Base) do
      
      Bar.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
      Bar.Position         = UDim2.new(0, 5, 0, 20)
      Bar.Size             = UDim2.new(0, 240, 0, 25) -- This is the only one not using X Scale lol
      Bar.BorderSizePixel  = 0
      Bar.ZIndex           = 10
      Bar.Name             = "Frame_2"

      Input = Instance.new("TextBox", Bar) do

         Input.BackgroundTransparency = 1
         Input.MultiLine              = false
         Input.Position               = UDim2.new(0, 2, 0, 0)
         Input.Size                   = UDim2.new(1, -4, 1, 0)
         Input.ZIndex                 = 10
         Input.BorderSizePixel        = 0
         Input.FontFace               = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
         Input.PlaceholderText        = "Command Bar (" .. Components.Configurations.Prefix .. ")"
         Input.Text                   = ""
         Input.TextColor3             = Color3.fromRGB(255, 255, 255)
         Input.TextSize               = 18
         Input.TextDirection          = Enum.TextDirection.LeftToRight
         Input.ClipsDescendants       = true
         Input.TextXAlignment         = Enum.TextXAlignment.Left
         Input.ClearTextOnFocus       = false

         --[[ Add Logic ]] do

            local function KeyInputs(Key)
               if Key == Components.Configurations.Prefix then
                  Input:CaptureFocus()
               end
            end

            Components.Services.P.LocalPlayer:GetMouse().KeyDown:Connect(KeyInputs)
            
         end
      end

   end

   local Commands = Instance.new("Frame", Base) do
      
      Commands.AnchorPoint            = Vector2.new(0, 1)
      Commands.Position               = UDim2.new(0, 0, 1, 0)
      Commands.BackgroundColor3       = Color3.fromRGB(36, 36, 37)
      Commands.BackgroundTransparency = 0
      Commands.ZIndex                 = 1
      Commands.Size                   = UDim2.new(1, 0, 0, 175)
      Commands.BorderSizePixel        = 0

      local Dictionary = Instance.new("ScrollingFrame", Commands) do
         
         -- Dictionary.AnchorPoint = Vector2.new(1, 0.5)
         Dictionary.Size                       = UDim2.new(1, 0, 1, 0)
         Dictionary.Position                   = UDim2.new(0, 0, 0, 0)
         Dictionary.BackgroundTransparency     = 1
         Dictionary.AutomaticCanvasSize        = Enum.AutomaticSize.Y
         Dictionary.CanvasSize                 = UDim2.new(0, 0, 0, 0)
         Dictionary.ScrollBarImageTransparency = 0
         Dictionary.BorderSizePixel            = 0
         Dictionary.ScrollBarThickness         = 8 do

            -- Useless textures
            
            Dictionary.TopImage    = "rbxasset://textures/ui/Scroll/scroll-middle.png"
            Dictionary.MidImage    = "rbxasset://textures/ui/Scroll/scroll-middle.png"
            Dictionary.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"

         end

         Dictionary.ScrollBarImageColor3 = Color3.fromRGB(78, 78, 79)

         local Layout = Instance.new("UIListLayout", Dictionary) do end

         local Padding = Instance.new("UIPadding", Dictionary) do
            
            -- Padding.PaddingTop = UDim.new(0, 0)
            Padding.PaddingLeft = UDim.new(0, 5)
            Padding.PaddingBottom = UDim.new(0, 3)

         end
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

         New.Size                   = UDim2.new(1, 0, 0, 21)
         New.BackgroundTransparency = 1
         New.BackgroundColor3       = Color3.fromRGB(36, 36, 37)
         New.FontFace               = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
         New.TextSize               = 18
         New.TextXAlignment         = Enum.TextXAlignment.Center
         New.ZIndex                 = 1
         New.Text                   = table.concat(Alias, " / ")
         New.TextColor3             = Color3.fromRGB(255, 255, 255)
         New.TextXAlignment         = Enum.TextXAlignment.Left
         New.BorderSizePixel = 0
   
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

Input.FocusLost:Connect(function()
   -- local Prefix = Components.Configurations.Prefix

   -- if not string.find(Input.Text, Prefix) then
   --    CreateSidenote("Invalid Command", "Usage of " .. Prefix .. " is required before any type of command.")
   -- end

   local Saved = Input.Text

   task.spawn(function()
      repeat
         Input.Text = ""

         Components.Services.RUS.Heartbeat:Wait()
      until Input.Text == ""
   end)

   Handle(Saved)
end)

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

   if string.find(string.lower(identifyexecutor()), "solara") then
      
      Command({ "open-url", "openurl", "open", "url" }, function(...)
         local Arguments = {...}
         table.remove(Arguments, 1)

         local Webpage = table.concat(Arguments, " ")

         if not string.find("https://", Webpage) then
            Webpage = "https://" .. Webpage
         end

         Get(game, "LinkingService\0"):OpenUrl(Webpage)
      end)

      Command({ "files", "file-explorer", "system", "sys" }, function()
         Get(game, "LinkingService\0"):OpenUrl("\\")
      end)

   end

   Command({ "dex", "newdex", "explorer" }, function()
      CreateSidenote("Loading", "Depending on your exploit, this may take a second.")

      loadstring(game:HttpGet("https://raw.githubusercontent.com/DarkNetworks/Infinite-Yield/main/dex.lua"))()
   end)

   Command({ "rj", "rejoin", "rej", "rjoin" }, function()
      Components.Services.TP:TeleportToPlaceInstance(game.PlaceId, game.JobId, You)
   end)

   Command({ "goto", "to", "tpto" }, function(...)
      local Arguments = {...}
      table.remove(Arguments, 1)
      
      local Target = FindPlayer(table.concat(Arguments, " "))

      if not Target then
         return
      end
      
      You.Character:FindFirstChild("HumanoidRootPart").CFrame = Get(game, "Players")[Target.Name].Character:FindFirstChild("HumanoidRootPart").CFrame * CFrame.new(1.5, 0, 2)
   end)

   Command({ "rspy", "remotespy" }, function()
      if select(1, pcall(hookfunction)) then
         CreateNotification("Unsupported Command", "Your exploit does not meet the requirements to run this command.\nMissing: <b>hookfunction</b>")
      else
         CreateSidenote("Loading", "Simple Spy is currently launching.")

         loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/78n/SimpleSpy/main/SimpleSpyBeta.lua"))()
      end
   end)

   Command({ "ws", "speed", "walkspeed" }, function(...)
      local Arguments = {...}
      table.remove(Arguments, 1)

      local Amount = tonumber(table.concat(Arguments, " "))

      You.Character:FindFirstChild("Humanoid").WalkSpeed = Amount
   end)

   Command({ "jp", "jumppower", "jpower", "jpw" }, function(...)
      local Arguments = {...}
      table.remove(Arguments, 1)

      local Amount = tonumber(table.concat(Arguments, " "))

      You.Character:FindFirstChild("Humanoid").JumpPower = Amount
   end)

   Command({ "reload", "relaunch", "restart" }, function()
      CreateNotification("Loading", "The script is attempting to relaunch.\nThis should take at most a few seconds.")
      Disabled = true

      task.wait(0.25)
      Get(game, "CoreGui")[Factor]:Destroy()

      loadstring(game:HttpGet(
         "https://github.com/mr-suno/Prism-Admin/blob/main/main.lua?raw=true"
      ))()
   end)

   Command({ "close", "quit", "stop" }, function()
      CreateNotification("Loading", "The script is currently shutting down.")
      Disabled = true

      task.wait(0.25)
      Get(game, "CoreGui")[Factor]:Destroy()
   end)

   Command({ "hh", "hipheight", "height" }, function(...)
      local Arguments = {...}
      table.remove(Arguments, 1)

      local Amount = tonumber(table.concat(Arguments, " "))

      if Amount < 0 then
         Amount = 0
      end

      if Amount > 999 then
         Amount = 999
      end

      You.Character:FindFirstChild("Humanoid").HipHeight = Amount
   end)

   Command({ "cb", "cbring", "clientbring", "cbr" }, function(...)
      local Arguments = {...}
      table.remove(Arguments, 1)
      
      local Target = FindPlayer(table.concat(Arguments, " "))

      if not Target then
         return
      end

      Get(game, "Players")[Target.Name].Character:FindFirstChild("HumanoidRootPart").CFrame = You.Character:FindFirstChild("HumanoidRootPart").CFrame * CFrame.new(3, 0, 0)
   end)

   Command({ "shout", "createshout", "cs" }, function(...)
      local Arguments = {...}
      table.remove(Arguments, 1)

      local Caption = table.concat(Arguments, " ")

      CreateNotification("My Notification", Caption)
   end)

   Command({ "notify", "notification", "sn" }, function(...)
      local Arguments = {...}
      table.remove(Arguments, 1)

      local Caption = table.concat(Arguments, " ")

      CreateSidenote("My Note", Caption)
   end)

   Command({ "prefix", "pre", "pfx" }, function(...)
      local Arguments = {...}
      table.remove(Arguments, 1)

      local Caption = tostring(table.concat(Arguments, " "))

      if string.len(Caption) > 1 or string.len(Caption) < 1 then
         CreateNotification("Invalid Prefix Length", "Your custom prefix MUST be one character long.")
      else
         Components.Configurations.Prefix = Caption
         Input.PlaceholderText = "Command Bar (" .. Caption .. ")"

         CreateSidenote("Prefix Changed", "Prism will now only respond to your prefix: <b>" .. Caption .. "</b>")
      end
   end)

   Command({ "void", "plrvoid" }, function()
      workspace.FallenPartsDestroyHeight = -math.huge

      local Old = You.Character:FindFirstChild("HumanoidRootPart").CFrame

      You.Character:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new(You.Character:FindFirstChild("HumanoidRootPart").CFrame.X, You.Character:FindFirstChild("HumanoidRootPart").CFrame.Y - 1000, You.Character:FindFirstChild("HumanoidRootPart").CFrame.Z)
   
      task.wait(2)

      You.Character:FindFirstChild("HumanoidRootPart").CFrame = Old
   end)

end
