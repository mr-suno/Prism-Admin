--[[

   UI Copied from Infinite Yield

   Credits: Suno, programmer, UI designer (Sort of), everything else.

]]


local Get = game.GetService

local Components = {
   ["Services"] = {
      ["TCS"] = Get(game, "TextChatService"),
      ["RS"] = Get(game, "ReplicatedStorage"),
      ["P"] = Get(game, "Players"),
      ["CG"] = Get(game, "CoreGui")
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

   local function CreateNotification(Title: string, Content: string)

      for _, Container in ipairs(Components.Services.CG:GetChildren()) do if Container:IsA("ScreenGui") and string.find(Container.Name, "Prism") then for _, Expired in ipairs(Container.Folder:GetChildren()) do if Expired:IsA("Frame") and string.find(Expired.Name, "Notification") then Expired:Destroy() end end end end

      local Notification = Instance.new("Frame", Holder) do
         
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
         
         Information.AnchorPoint = Vector2.new(1, 0)
         Information.BackgroundTransparency = 1
         Information.Image = "rbxassetid://3523243755"
         Information.Size  = UDim2.new(0, 16, 0, 16)
         Information.Position = UDim2.new(1, 0, 0, 0)
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

   end

   Main.Name = "Prism Admin " .. Components.Configurations["Content-Type"] .. " v" .. Components.Configurations.Version
   Header.Text = Main.Name
end

Chat("[+] loaded")
