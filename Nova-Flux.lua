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
    CornerRadius = UDim.new(0, 8)
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
    local buttons = {"Overview", "Fruits", "Quests/Raids", "Sea-Events", "Teleport", "Misc", "Settings"}
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
    
    for _, buttonText in ipairs(buttons) do
        local ButtonContainer = Instance.new("Frame")
        ButtonContainer.Name = buttonText .. "Container"
        ButtonContainer.Size = UDim2.new(0.9, 0, 0, 30)
        ButtonContainer.Position = UDim2.new(0.05, 0, 0, currentY)
        ButtonContainer.BackgroundColor3 = UISettings.ButtonColor
        ButtonContainer.BackgroundTransparency = 0
        ButtonContainer.Parent = NavBar
        
        local ButtonCorner = Instance.new("UICorner")
        ButtonCorner.CornerRadius = UDim.new(0, 6)
        ButtonCorner.Parent = ButtonContainer
        
        local Button = Instance.new("TextButton")
        Button.Name = buttonText .. "Button"
        Button.Size = UDim2.new(1, 0, 1, 0)
        Button.Position = UDim2.new(0, 0, 0, 0)
        Button.BackgroundTransparency = 1
        Button.Text = buttonText
        Button.TextColor3 = UISettings.TextColor
        Button.TextSize = 12
        Button.Font = UISettings.FontFamily
        Button.Parent = ButtonContainer
        
        -- Button Functionality
        Button.MouseButton1Click:Connect(function()
            clearContentFrame()
            ComingSoonLabel.Text = buttonText .. " - Coming Soon!"
            
            -- Highlight the selected button
            for _, otherButton in ipairs(NavBar:GetChildren()) do
                if otherButton:IsA("Frame") and otherButton.Name:find("Container") then
                    otherButton.BackgroundColor3 = UISettings.ButtonColor
                end
            end
            ButtonContainer.BackgroundColor3 = UISettings.HighlightColor
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
    end
    clearContentFrame()
    ComingSoonLabel.Text = "Overview - Coming Soon!"
    
    return MainUI
end

-- Initialize the UI
local Window = Library:CreateWindow("Nova Flux | Blox Fruits")
