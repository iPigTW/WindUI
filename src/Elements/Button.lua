local Creator = require("../Creator")
local New = Creator.New

local Element = {}

function Element:New(Config)
    local Button = {
        __type = "Button",
        Title = Config.Title or "Button",
        Desc = Config.Desc or nil,
        Locked = Config.Locked or false,
        Callback = Config.Callback or function() end,
        UIElements = {}
    }
    
    local CanCallback = true
    
    Button.ButtonFrame = require("../Components/Element")({
        Title = Button.Title,
        Desc = Button.Desc,
        Parent = Config.Parent,
        Theme = Config.Theme,
        TextOffset = 20,
        Hover = true,
    })
    
    
    function Button:Lock()
        CanCallback = false
        return Button.ButtonFrame:Lock()
    end
    function Button:Unlock()
        CanCallback = true
        return Button.ButtonFrame:Unlock()
    end
    
    if Button.Locked then
        Button:Lock()
    end

    Button.ButtonFrame.UIElements.Main.MouseButton1Click:Connect(function()
        if CanCallback then
            task.spawn(function()
                Button.Callback()
            end)
        end
    end)
    return Button.__type, Button
end

return Element
