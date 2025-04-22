local Library = {}

-- Create main UI elements
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- UI Settings
local UISettings = {
    MainColor = Color3.fromRGB(0, 0, 0), -- AMOLED black
    AccentColor = Color3.fromRGB(10, 10, 10), -- Slightly lighter black
    ButtonColor = Color3.fromRGB(20, 20, 25), -- Darker button background
    TextColor = Color3.fromRGB(255, 255, 255),
    HighlightColor = Color3.fromRGB(100, 90, 255),
    FontFamily = Enum.Font.GothamBold,
    ButtonSize = UDim2.new(0, 150, 0, 25),
    CornerRadius = UDim.new(0, 8),
    -- UI Scale settings
    Scales = {
        Small = 0.8,
        Normal = 1,
        Large = 1.2
    },
    CurrentScale = 1
}

-- Icon IDs (replace these with your actual icon IDs)
local Icons = {
    Overview = "rbxassetid://11347105925", -- You can update this to a dashboard/overview icon
    Farm = "rbxassetid://11347105800",
    Sea = "rbxassetid://11347105740",
    Quest = "rbxassetid://11347105646",
    Fruit = "rbxassetid://11347105571",
    Teleport = "rbxassetid://11347105494",
    Visual = "rbxassetid://11347105440",
    Shop = "rbxassetid://11347105377",
    Misc = "rbxassetid://11347105313"
}

function Library:CreateWindow(title)
    -- Remove existing UI if it exists
    local existingUI = CoreGui:FindFirstChild("NovaFluxUI")
    if existingUI then
        existingUI:Destroy()
    end

    -- Main Frame
    local MainUI = Instance.new("ScreenGui")
    MainUI.Name = "NovaFluxUI"
    MainUI.Parent = CoreGui
    
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 450, 0, 300) -- Even smaller size
    MainFrame.Position = UDim2.new(0.5, -225, 0.5, -150) -- Adjusted position
    MainFrame.BackgroundColor3 = UISettings.MainColor
    MainFrame.BackgroundTransparency = 0.1 -- Slight transparency
    MainFrame.Parent = MainUI
    
    -- Add rounded corners
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UISettings.CornerRadius
    Corner.Parent = MainFrame
    
    -- Title Bar
    local TitleBar = Instance.new("Frame")
    TitleBar.Name = "TitleBar"
    TitleBar.Size = UDim2.new(1, 0, 0, 30)
    TitleBar.BackgroundColor3 = UISettings.AccentColor
    TitleBar.BackgroundTransparency = 0.1
    TitleBar.Parent = MainFrame
    
    local TitleCorner = Instance.new("UICorner")
    TitleCorner.CornerRadius = UISettings.CornerRadius
    TitleCorner.Parent = TitleBar
    
    -- Title Text
    local TitleText = Instance.new("TextLabel")
    TitleText.Name = "Title"
    TitleText.Size = UDim2.new(1, -100, 1, 0)
    TitleText.Position = UDim2.new(0, 10, 0, 0)
    TitleText.BackgroundTransparency = 1
    TitleText.Text = title
    TitleText.TextColor3 = UISettings.TextColor
    TitleText.TextSize = 16
    TitleText.Font = UISettings.FontFamily
    TitleText.TextXAlignment = Enum.TextXAlignment.Left
    TitleText.Parent = TitleBar
    
    -- Close Button
    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.Position = UDim2.new(1, -30, 0, 0)
    CloseButton.BackgroundTransparency = 1
    CloseButton.Text = "×"
    CloseButton.TextColor3 = UISettings.TextColor
    CloseButton.TextSize = 20
    CloseButton.Font = UISettings.FontFamily
    CloseButton.Parent = TitleBar
    
    -- Minimize Button
    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Name = "MinimizeButton"
    MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
    MinimizeButton.Position = UDim2.new(1, -60, 0, 0)
    MinimizeButton.BackgroundTransparency = 1
    MinimizeButton.Text = "-"
    MinimizeButton.TextColor3 = UISettings.TextColor
    MinimizeButton.TextSize = 20
    MinimizeButton.Font = UISettings.FontFamily
    MinimizeButton.Parent = TitleBar
    
    -- Navigation Bar
    local NavBar = Instance.new("Frame")
    NavBar.Name = "NavBar"
    NavBar.Size = UDim2.new(0, 110, 1, -30) -- Even smaller nav bar
    NavBar.Position = UDim2.new(0, 0, 0, 30)
    NavBar.BackgroundColor3 = UISettings.AccentColor
    NavBar.BackgroundTransparency = 0.1
    NavBar.Parent = MainFrame
    
    local NavCorner = Instance.new("UICorner")
    NavCorner.CornerRadius = UISettings.CornerRadius
    NavCorner.Parent = NavBar
    
    -- Content Frame
    local ContentFrame = Instance.new("Frame")
    ContentFrame.Name = "ContentFrame"
    ContentFrame.Size = UDim2.new(1, -120, 1, -40) -- Adjusted for new size
    ContentFrame.Position = UDim2.new(0, 115, 0, 35)
    ContentFrame.BackgroundColor3 = UISettings.MainColor
    ContentFrame.BackgroundTransparency = 0.1
    ContentFrame.Parent = MainFrame
    
    -- Coming Soon Label (hidden by default)
    local ComingSoonLabel = Instance.new("TextLabel")
    ComingSoonLabel.Name = "ComingSoonLabel"
    ComingSoonLabel.Size = UDim2.new(1, -20, 0, 30)
    ComingSoonLabel.Position = UDim2.new(0, 10, 0, 10)
    ComingSoonLabel.BackgroundTransparency = 1
    ComingSoonLabel.Text = "Coming Soon!"
    ComingSoonLabel.TextColor3 = UISettings.TextColor
    ComingSoonLabel.TextSize = 18
    ComingSoonLabel.Font = UISettings.FontFamily
    ComingSoonLabel.Parent = ContentFrame
    ComingSoonLabel.Visible = false
    
    -- Create Navigation Buttons
    local buttons = {
        {text = "Overview", icon = Icons.Overview},
        {text = "Farm", icon = Icons.Farm},
        {text = "Sea", icon = Icons.Sea},
        {text = "Quests/Items", icon = Icons.Quest},
        {text = "Fruit/Raid", icon = Icons.Fruit},
        {text = "Teleport", icon = Icons.Teleport},
        {text = "Visual", icon = Icons.Visual},
        {text = "Shop", icon = Icons.Shop},
        {text = "Misc", icon = Icons.Misc},
        {text = "Settings", icon = Icons.Misc}
    }
    local buttonSpacing = 2
    local currentY = 5
    
    -- Function to clear content frame
    local function clearContentFrame()
        for _, child in ipairs(ContentFrame:GetChildren()) do
            if child.Name ~= "ComingSoonLabel" then
                child:Destroy()
            end
        end
        ComingSoonLabel.Visible = true
    end
    
    -- Function to update Overview panel with player info
    local function updateOverviewPanel()
        clearContentFrame()
        ComingSoonLabel.Text = "Overview - Player Stats Coming Soon!"
        -- Here you can add code to display player info in the future
        -- Example structure for future implementation:
        --[[
        local StatsContainer = Instance.new("Frame")
        StatsContainer.Name = "StatsContainer"
        StatsContainer.Size = UDim2.new(1, -20, 1, -20)
        StatsContainer.Position = UDim2.new(0, 10, 0, 10)
        StatsContainer.BackgroundTransparency = 1
        StatsContainer.Parent = ContentFrame
        
        -- Add player stats here
        -- Level, Money, Fruits, etc.
        ]]
    end
    
    -- Function to update UI Scale
    local function updateUIScale(scale)
        UISettings.CurrentScale = scale
        local newWidth = math.floor(450 * scale)
        local newHeight = math.floor(300 * scale)
        
        -- Update MainFrame size and position
        MainFrame.Size = UDim2.new(0, newWidth, 0, newHeight)
        MainFrame.Position = UDim2.new(0.5, -newWidth/2, 0.5, -newHeight/2)
        
        -- Update other elements' sizes proportionally
        NavBar.Size = UDim2.new(0, math.floor(110 * scale), 1, -30)
        ContentFrame.Size = UDim2.new(1, -math.floor(120 * scale), 1, -40)
        ContentFrame.Position = UDim2.new(0, math.floor(115 * scale), 0, 35)
        
        -- Update button sizes and positions
        for _, button in ipairs(NavBar:GetChildren()) do
            if button:IsA("Frame") and button.Name:find("Container") then
                button.Size = UDim2.new(0.9, 0, 0, math.floor(30 * scale))
            end
        end
    end

    -- Create Settings Dropdown
    local function createSettingsDropdown(settingsButton)
        local DropdownContainer = Instance.new("Frame")
        DropdownContainer.Name = "SettingsDropdown"
        DropdownContainer.Size = UDim2.new(0, 120, 0, 110)
        DropdownContainer.Position = UDim2.new(1, 10, 0, 0)
        DropdownContainer.BackgroundColor3 = UISettings.ButtonColor
        DropdownContainer.BackgroundTransparency = 0
        DropdownContainer.Visible = false
        DropdownContainer.Parent = settingsButton
        
        local DropdownCorner = Instance.new("UICorner")
        DropdownCorner.CornerRadius = UDim.new(0, 6)
        DropdownCorner.Parent = DropdownContainer
        
        -- UI Scale Label
        local ScaleLabel = Instance.new("TextLabel")
        ScaleLabel.Name = "ScaleLabel"
        ScaleLabel.Size = UDim2.new(1, -20, 0, 25)
        ScaleLabel.Position = UDim2.new(0, 10, 0, 5)
        ScaleLabel.BackgroundTransparency = 1
        ScaleLabel.Text = "UI Scale"
        ScaleLabel.TextColor3 = UISettings.TextColor
        ScaleLabel.TextSize = 14
        ScaleLabel.Font = UISettings.FontFamily
        ScaleLabel.TextXAlignment = Enum.TextXAlignment.Left
        ScaleLabel.Parent = DropdownContainer
        
        -- Scale Options
        local scaleOptions = {"Small", "Normal", "Large"}
        local currentY = 35
        
        for _, scale in ipairs(scaleOptions) do
            local ScaleButton = Instance.new("TextButton")
            ScaleButton.Name = scale .. "Scale"
            ScaleButton.Size = UDim2.new(1, -20, 0, 20)
            ScaleButton.Position = UDim2.new(0, 10, 0, currentY)
            ScaleButton.BackgroundColor3 = UISettings.MainColor
            ScaleButton.BackgroundTransparency = 0.5
            ScaleButton.Text = scale
            ScaleButton.TextColor3 = UISettings.TextColor
            ScaleButton.TextSize = 12
            ScaleButton.Font = UISettings.FontFamily
            ScaleButton.Parent = DropdownContainer
            
            local ButtonCorner = Instance.new("UICorner")
            ButtonCorner.CornerRadius = UDim.new(0, 4)
            ButtonCorner.Parent = ScaleButton
            
            -- Scale Button Click Handler
            ScaleButton.MouseButton1Click:Connect(function()
                updateUIScale(UISettings.Scales[scale])
                -- Update button appearances
                for _, btn in ipairs(DropdownContainer:GetChildren()) do
                    if btn:IsA("TextButton") then
                        btn.BackgroundTransparency = 0.5
                    end
                end
                ScaleButton.BackgroundTransparency = 0
            end)
            
            currentY = currentY + 25
        end
        
        return DropdownContainer
    end
    
    for _, buttonInfo in ipairs(buttons) do
        local ButtonContainer = Instance.new("Frame")
        ButtonContainer.Name = buttonInfo.text .. "Container"
        ButtonContainer.Size = UDim2.new(0.9, 0, 0, 30)
        ButtonContainer.Position = UDim2.new(0.05, 0, 0, currentY)
        ButtonContainer.BackgroundColor3 = UISettings.ButtonColor
        ButtonContainer.BackgroundTransparency = 0
        ButtonContainer.Parent = NavBar
        
        local ButtonCorner = Instance.new("UICorner")
        ButtonCorner.CornerRadius = UDim.new(0, 6)
        ButtonCorner.Parent = ButtonContainer
        
        -- Icon Image
        local IconImage = Instance.new("ImageLabel")
        IconImage.Name = "Icon"
        IconImage.Size = UDim2.new(0, 16, 0, 16)
        IconImage.Position = UDim2.new(0, 7, 0.5, -8)
        IconImage.BackgroundTransparency = 1
        IconImage.Image = buttonInfo.icon
        IconImage.ImageColor3 = UISettings.TextColor
        IconImage.Parent = ButtonContainer
        
        local Button = Instance.new("TextButton")
        Button.Name = buttonInfo.text .. "Button"
        Button.Size = UDim2.new(1, -30, 1, 0)
        Button.Position = UDim2.new(0, 25, 0, 0)
        Button.BackgroundTransparency = 1
        Button.Text = buttonInfo.text
        Button.TextColor3 = UISettings.TextColor
        Button.TextSize = 12
        Button.Font = UISettings.FontFamily
        Button.TextXAlignment = Enum.TextXAlignment.Left
        Button.Parent = ButtonContainer
        
        -- Button Functionality
        Button.MouseButton1Click:Connect(function()
            if buttonInfo.text == "Overview" then
                updateOverviewPanel()
            elseif buttonInfo.text == "Settings" then
                -- Toggle Settings Dropdown
                local dropdown = ButtonContainer:FindFirstChild("SettingsDropdown")
                if not dropdown then
                    dropdown = createSettingsDropdown(ButtonContainer)
                end
                dropdown.Visible = not dropdown.Visible
            else
                clearContentFrame()
                ComingSoonLabel.Text = buttonInfo.text .. " - Coming Soon!"
            end
            
            -- Highlight the selected button
            for _, otherButton in ipairs(NavBar:GetChildren()) do
                if otherButton:IsA("Frame") and otherButton.Name:find("Container") then
                    otherButton.BackgroundColor3 = UISettings.ButtonColor
                    local icon = otherButton:FindFirstChild("Icon")
                    if icon then
                        icon.ImageColor3 = UISettings.TextColor
                    end
                end
            end
            ButtonContainer.BackgroundColor3 = UISettings.HighlightColor
            local icon = ButtonContainer:FindFirstChild("Icon")
            if icon then
                icon.ImageColor3 = Color3.fromRGB(255, 255, 255)
            end
        end)
        
        -- Hover Effect
        ButtonContainer.MouseEnter:Connect(function()
            if ButtonContainer.BackgroundColor3 ~= UISettings.HighlightColor then
                TweenService:Create(ButtonContainer, TweenInfo.new(0.3), {
                    BackgroundColor3 = Color3.fromRGB(30, 30, 35)
                }):Play()
            end
        end)
        
        ButtonContainer.MouseLeave:Connect(function()
            if ButtonContainer.BackgroundColor3 ~= UISettings.HighlightColor then
                TweenService:Create(ButtonContainer, TweenInfo.new(0.3), {
                    BackgroundColor3 = UISettings.ButtonColor
                }):Play()
            end
        end)
        
        currentY = currentY + 33 + buttonSpacing
    end
    
    -- Dragging Functionality
    local dragging
    local dragInput
    local dragStart
    local startPos
    
    local function updateDrag(input)
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    
    TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
        end
    end)
    
    TitleBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            updateDrag(input)
        end
    end)
    
    -- Close Button Functionality
    CloseButton.MouseButton1Click:Connect(function()
        MainUI:Destroy()
    end)
    
    -- Minimize Button Functionality
    local minimized = false
    local originalSize = MainFrame.Size
    
    MinimizeButton.MouseButton1Click:Connect(function()
        minimized = not minimized
        if minimized then
            NavBar.Visible = false
            ContentFrame.Visible = false
            MainFrame:TweenSize(UDim2.new(0, 450, 0, 30), "Out", "Quad", 0.3, true)
        else
            MainFrame:TweenSize(originalSize, "Out", "Quad", 0.3, true)
            wait(0.3) -- Wait for animation to complete
            NavBar.Visible = true
            ContentFrame.Visible = true
        end
    end)
    
    -- Show Overview by default
    local OverviewButton = NavBar:FindFirstChild("OverviewContainer")
    if OverviewButton then
        OverviewButton.BackgroundColor3 = UISettings.HighlightColor
        local icon = OverviewButton:FindFirstChild("Icon")
        if icon then
            icon.ImageColor3 = Color3.fromRGB(255, 255, 255)
        end
    end
    updateOverviewPanel()
    
    return MainUI
end

-- Initialize the UI
local Window = Library:CreateWindow("Nova Flux | Blox Fruits")
