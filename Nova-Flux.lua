local Library = {}

-- Create main UI elements
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Debug flag
local isDebugMode = true

-- Debug Console Messages
local debugMessages = {}
local maxDebugMessages = 100

-- Debug print function
local function debugPrint(message)
    if isDebugMode then
        local timeStamp = os.date("%H:%M:%S")
        local formattedMessage = string.format("[%s] %s", timeStamp, message)
        print(formattedMessage)
        
        -- Add to debug messages
        table.insert(debugMessages, 1, formattedMessage)
        if #debugMessages > maxDebugMessages then
            table.remove(debugMessages)
        end
        
        -- Update console if it exists
        local ui = game:GetService("CoreGui"):FindFirstChild("NovaFluxUI")
        if ui then
            local console = ui.MainFrame.ContentFrame:FindFirstChild("DebugConsole")
            if console then
                updateDebugConsole(console)
            end
        end
    end
end

-- UI Settings
local UISettings = {
    MainColor = Color3.fromRGB(0, 0, 0), -- AMOLED black
    AccentColor = Color3.fromRGB(10, 10, 10), -- Slightly lighter black
    ButtonColor = Color3.fromRGB(20, 20, 25), -- Darker button background
    TextColor = Color3.fromRGB(255, 255, 255),
    ConsoleColor = Color3.fromRGB(50, 255, 50), -- Bright green for console text
    ConsoleBackground = Color3.fromRGB(15, 15, 20), -- Slightly lighter than AMOLED for console
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
    Misc = "rbxassetid://11347105313",
    Advanced = "rbxassetid://11347105313", -- You can update this to a proper debug/advanced icon
    Settings = "rbxassetid://11347105313"
}

-- Function to create debug console
local function createDebugConsole(parent)
    -- Main container with padding
    local ConsoleContainer = Instance.new("Frame")
    ConsoleContainer.Name = "ConsoleContainer"
    ConsoleContainer.Size = UDim2.new(1, -20, 1, -20)
    ConsoleContainer.Position = UDim2.new(0, 10, 0, 10)
    ConsoleContainer.BackgroundColor3 = UISettings.ConsoleBackground
    ConsoleContainer.BackgroundTransparency = 0
    ConsoleContainer.BorderSizePixel = 0
    ConsoleContainer.Parent = parent

    -- Material Design corners
    local ContainerCorner = Instance.new("UICorner")
    ContainerCorner.CornerRadius = UDim.new(0, 12) -- Material You 3 style rounded corners
    ContainerCorner.Parent = ConsoleContainer
    
    -- Add subtle padding
    local Padding = Instance.new("UIPadding")
    Padding.PaddingTop = UDim.new(0, 10)
    Padding.PaddingBottom = UDim.new(0, 10)
    Padding.PaddingLeft = UDim.new(0, 10)
    Padding.PaddingRight = UDim.new(0, 10)
    Padding.Parent = ConsoleContainer

    -- Console title
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Name = "Title"
    TitleLabel.Size = UDim2.new(1, -20, 0, 30)
    TitleLabel.Position = UDim2.new(0, 10, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = "Debug Console"
    TitleLabel.TextColor3 = UISettings.ConsoleColor
    TitleLabel.TextSize = 16
    TitleLabel.Font = UISettings.FontFamily
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = ConsoleContainer

    -- Scrolling frame for messages
    local ConsoleFrame = Instance.new("ScrollingFrame")
    ConsoleFrame.Name = "DebugConsole"
    ConsoleFrame.Size = UDim2.new(1, -4, 1, -45) -- Account for title and padding
    ConsoleFrame.Position = UDim2.new(0, 2, 0, 35)
    ConsoleFrame.BackgroundTransparency = 1
    ConsoleFrame.BorderSizePixel = 0
    ConsoleFrame.ScrollBarThickness = 4
    ConsoleFrame.ScrollBarImageColor3 = UISettings.ConsoleColor
    ConsoleFrame.ScrollBarImageTransparency = 0.5
    ConsoleFrame.ScrollingDirection = Enum.ScrollingDirection.Y
    ConsoleFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    ConsoleFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    ConsoleFrame.Parent = ConsoleContainer
    
    -- Clear button with Material Design
    local ClearButton = Instance.new("TextButton")
    ClearButton.Name = "ClearButton"
    ClearButton.Size = UDim2.new(0, 70, 0, 28)
    ClearButton.Position = UDim2.new(1, -80, 0, 2)
    ClearButton.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    ClearButton.Text = "Clear"
    ClearButton.TextColor3 = UISettings.ConsoleColor
    ClearButton.TextSize = 14
    ClearButton.Font = UISettings.FontFamily
    ClearButton.Parent = ConsoleContainer
    
    -- Button effects
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 8)
    ButtonCorner.Parent = ClearButton
    
    -- Button hover effect
    ClearButton.MouseEnter:Connect(function()
        TweenService:Create(ClearButton, TweenInfo.new(0.3), {
            BackgroundColor3 = Color3.fromRGB(50, 50, 55)
        }):Play()
    end)
    
    ClearButton.MouseLeave:Connect(function()
        TweenService:Create(ClearButton, TweenInfo.new(0.3), {
            BackgroundColor3 = Color3.fromRGB(40, 40, 45)
        }):Play()
    end)
    
    ClearButton.MouseButton1Click:Connect(function()
        debugMessages = {}
        updateDebugConsole(ConsoleFrame)
    end)
    
    return ConsoleFrame
end

-- Function to update debug console
local function updateDebugConsole(console)
    -- Clear existing messages
    for _, child in ipairs(console:GetChildren()) do
        if child:IsA("TextLabel") then
            child:Destroy()
        end
    end
    
    -- Add messages
    local currentY = 5
    for i, message in ipairs(debugMessages) do
        local MessageLabel = Instance.new("TextLabel")
        MessageLabel.Size = UDim2.new(1, -10, 0, 20)
        MessageLabel.Position = UDim2.new(0, 5, 0, currentY)
        MessageLabel.BackgroundTransparency = 1
        MessageLabel.Text = message
        MessageLabel.TextColor3 = UISettings.ConsoleColor
        MessageLabel.TextSize = 14
        MessageLabel.Font = Enum.Font.Code
        MessageLabel.TextXAlignment = Enum.TextXAlignment.Left
        MessageLabel.TextWrapped = true
        MessageLabel.Parent = console
        
        -- Add hover highlight effect
        MessageLabel.MouseEnter:Connect(function()
            MessageLabel.TextTransparency = 0.2
        end)
        
        MessageLabel.MouseLeave:Connect(function()
            MessageLabel.TextTransparency = 0
        end)
        
        currentY = currentY + 22 -- Slightly increased spacing
    end
end

function Library:CreateWindow(title)
    debugPrint("Creating window with title: " .. title)
    
    -- Remove existing UI if it exists
    local existingUI = CoreGui:FindFirstChild("NovaFluxUI")
    if existingUI then
        debugPrint("Removing existing UI")
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
        {text = "Advanced", icon = Icons.Advanced},
        {text = "Settings", icon = Icons.Settings}
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
    
    -- Function to update UI Scale with debug
    local function updateUIScale(scale)
        debugPrint("Updating UI scale to: " .. tostring(scale))
        
        local success, err = pcall(function()
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
        end)
        
        if not success then
            debugPrint("Error updating UI scale: " .. tostring(err))
        end
    end

    -- Create Settings Dropdown with debug
    local function createSettingsDropdown(settingsButton)
        debugPrint("Creating settings dropdown")
        
        local success, dropdown = pcall(function()
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
                    debugPrint("Scale button clicked: " .. scale)
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
        end)
        
        if not success then
            debugPrint("Error creating settings dropdown: " .. tostring(dropdown))
            return nil
        end
        
        return dropdown
    end
    
    -- Button click handler with debug
    local function handleButtonClick(buttonInfo, ButtonContainer)
        debugPrint("Button clicked: " .. buttonInfo.text)
        
        local success, err = pcall(function()
            if buttonInfo.text == "Overview" then
                updateOverviewPanel()
            elseif buttonInfo.text == "Settings" then
                -- Toggle Settings Dropdown
                local dropdown = ButtonContainer:FindFirstChild("SettingsDropdown")
                if not dropdown then
                    dropdown = createSettingsDropdown(ButtonContainer)
                end
                if dropdown then
                    dropdown.Visible = not dropdown.Visible
                    debugPrint("Settings dropdown visibility: " .. tostring(dropdown.Visible))
                end
            elseif buttonInfo.text == "Advanced" then
                clearContentFrame()
                local console = createDebugConsole(ContentFrame)
                updateDebugConsole(console)
                ComingSoonLabel.Visible = false
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
        
        if not success then
            debugPrint("Error in button click handler: " .. tostring(err))
        end
    end

    -- Create buttons with debug
    for _, buttonInfo in ipairs(buttons) do
        local success, err = pcall(function()
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
                handleButtonClick(buttonInfo, ButtonContainer)
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
        end)
        
        if not success then
            debugPrint("Error creating button " .. buttonInfo.text .. ": " .. tostring(err))
        end
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
    
    -- Debug test function
    local function runDebugTests()
        debugPrint("Starting debug tests...")
        
        -- Test UI creation
        debugPrint("Testing UI elements...")
        assert(MainFrame, "MainFrame not created")
        assert(NavBar, "NavBar not created")
        assert(ContentFrame, "ContentFrame not created")
        
        -- Test button creation
        debugPrint("Testing buttons...")
        for _, buttonInfo in ipairs(buttons) do
            local button = NavBar:FindFirstChild(buttonInfo.text .. "Container")
            assert(button, "Button not found: " .. buttonInfo.text)
        end
        
        -- Test UI scaling
        debugPrint("Testing UI scaling...")
        for scale, value in pairs(UISettings.Scales) do
            debugPrint("Testing scale: " .. scale)
            updateUIScale(value)
            wait(1) -- Wait to see the change
        end
        
        -- Reset to normal scale
        updateUIScale(UISettings.Scales.Normal)
        
        debugPrint("Debug tests completed successfully!")
    end

    -- Run debug tests if in debug mode
    if isDebugMode then
        task.spawn(function()
            wait(1) -- Wait for UI to fully load
            runDebugTests()
        end)
    end

    return MainUI
end

-- Initialize the UI with debug
debugPrint("Initializing Nova Flux UI")
local Window = Library:CreateWindow("Nova Flux | Blox Fruits")
debugPrint("UI initialization complete")
