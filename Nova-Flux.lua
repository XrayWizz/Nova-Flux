local Library = {}

-- Create main UI elements
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- UI Settings with Material You 3 Theme
local UISettings = {
    -- Surface colors (Material You 3)
    MainColor = Color3.fromRGB(28, 27, 31), -- md.sys.color.surface
    AccentColor = Color3.fromRGB(32, 31, 35), -- md.sys.color.surface-container
    ButtonColor = Color3.fromRGB(73, 69, 79), -- md.sys.color.surface-container-low
    TextColor = Color3.fromRGB(230, 225, 229), -- md.sys.color.on-surface
    HighlightColor = Color3.fromRGB(201, 23, 27), -- Nebula Crimson Red accent
    SecondaryHighlight = Color3.fromRGB(171, 20, 23), -- Darker Nebula Red for states
    SurfaceContainerHigh = Color3.fromRGB(45, 44, 48), -- md.sys.color.surface-container-high
    OutlineColor = Color3.fromRGB(147, 143, 153), -- md.sys.color.outline
    
    -- Typography
    FontFamily = Enum.Font.GothamBold,
    ButtonSize = UDim2.new(0, 150, 0, 32), -- Material You 3 standard touch target
    CornerRadius = UDim.new(0, 12), -- Material You 3 medium roundness
    
    -- Elevation and States
    SurfaceElevation = 0.03, -- Base transparency for elevation effect
    HoverElevation = 0.01, -- Less transparency on hover
    PressedElevation = 0.05, -- More transparency when pressed
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
    MainFrame.Size = UDim2.new(0, 450, 0, 300)
    MainFrame.Position = UDim2.new(0.5, -225, 0.5, -150)
    MainFrame.BackgroundColor3 = UISettings.MainColor
    MainFrame.BackgroundTransparency = UISettings.SurfaceElevation
    MainFrame.Parent = MainUI
    
    -- Add subtle drop shadow
    local DropShadow = Instance.new("ImageLabel")
    DropShadow.Name = "DropShadow"
    DropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
    DropShadow.BackgroundTransparency = 1
    DropShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    DropShadow.Size = UDim2.new(1, 12, 1, 12)
    DropShadow.ZIndex = -1
    DropShadow.Image = "rbxassetid://6014261993"
    DropShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    DropShadow.ImageTransparency = 0.5
    DropShadow.Parent = MainFrame
    
    -- Add rounded corners
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UISettings.CornerRadius
    Corner.Parent = MainFrame
    
    -- Title Bar with elevated surface
    local TitleBar = Instance.new("Frame")
    TitleBar.Name = "TitleBar"
    TitleBar.Size = UDim2.new(1, 0, 0, 40)
    TitleBar.BackgroundColor3 = UISettings.SurfaceContainerHigh
    TitleBar.BackgroundTransparency = UISettings.SurfaceElevation
    TitleBar.Parent = MainFrame
    
    -- Add subtle stroke to TitleBar
    local TitleStroke = Instance.new("UIStroke")
    TitleStroke.Color = UISettings.OutlineColor
    TitleStroke.Transparency = 0.8
    TitleStroke.Thickness = 1
    TitleStroke.Parent = TitleBar
    
    local TitleCorner = Instance.new("UICorner")
    TitleCorner.CornerRadius = UISettings.CornerRadius
    TitleCorner.Parent = TitleBar
    
    -- Title Text with Material You 3 typography
    local TitleText = Instance.new("TextLabel")
    TitleText.Name = "Title"
    TitleText.Size = UDim2.new(1, -100, 1, 0)
    TitleText.Position = UDim2.new(0, 16, 0, 0)
    TitleText.BackgroundTransparency = 1
    TitleText.Text = title
    TitleText.TextColor3 = UISettings.TextColor
    TitleText.TextSize = 18
    TitleText.Font = UISettings.FontFamily
    TitleText.TextXAlignment = Enum.TextXAlignment.Left
    TitleText.Parent = TitleBar
    
    -- Update Close Button with Material You 3 styling
    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Size = UDim2.new(0, 40, 0, 40)
    CloseButton.Position = UDim2.new(1, -40, 0, 0)
    CloseButton.BackgroundTransparency = 1
    CloseButton.Text = "×"
    CloseButton.TextColor3 = UISettings.TextColor
    CloseButton.TextSize = 24
    CloseButton.Font = UISettings.FontFamily
    CloseButton.Parent = TitleBar
    
    -- Add hover effect for close button
    CloseButton.MouseEnter:Connect(function()
        TweenService:Create(CloseButton, TweenInfo.new(0.2), {
            TextColor3 = Color3.fromRGB(255, 80, 80)
        }):Play()
    end)
    
    CloseButton.MouseLeave:Connect(function()
        TweenService:Create(CloseButton, TweenInfo.new(0.2), {
            TextColor3 = UISettings.TextColor
        }):Play()
    end)
    
    -- Update Minimize Button with Material You 3 styling
    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Name = "MinimizeButton"
    MinimizeButton.Size = UDim2.new(0, 40, 0, 40)
    MinimizeButton.Position = UDim2.new(1, -80, 0, 0)
    MinimizeButton.BackgroundTransparency = 1
    MinimizeButton.Text = "−"
    MinimizeButton.TextColor3 = UISettings.TextColor
    MinimizeButton.TextSize = 24
    MinimizeButton.Font = UISettings.FontFamily
    MinimizeButton.Parent = TitleBar
    
    -- Add hover effect for minimize button
    MinimizeButton.MouseEnter:Connect(function()
        TweenService:Create(MinimizeButton, TweenInfo.new(0.2), {
            TextColor3 = UISettings.HighlightColor
        }):Play()
    end)
    
    MinimizeButton.MouseLeave:Connect(function()
        TweenService:Create(MinimizeButton, TweenInfo.new(0.2), {
            TextColor3 = UISettings.TextColor
        }):Play()
    end)
    
    -- Navigation Bar with elevated surface
    local NavBar = Instance.new("Frame")
    NavBar.Name = "NavBar"
    NavBar.Size = UDim2.new(0, 110, 1, -40)
    NavBar.Position = UDim2.new(0, 0, 0, 40)
    NavBar.BackgroundColor3 = UISettings.SurfaceContainerHigh
    NavBar.BackgroundTransparency = UISettings.SurfaceElevation
    NavBar.Parent = MainFrame
    
    -- Add subtle stroke to NavBar
    local NavStroke = Instance.new("UIStroke")
    NavStroke.Color = UISettings.OutlineColor
    NavStroke.Transparency = 0.8
    NavStroke.Thickness = 1
    NavStroke.Parent = NavBar
    
    local NavCorner = Instance.new("UICorner")
    NavCorner.CornerRadius = UISettings.CornerRadius
    NavCorner.Parent = NavBar
    
    -- Content Frame with Material You 3 elevation
    local ContentFrame = Instance.new("Frame")
    ContentFrame.Name = "ContentFrame"
    ContentFrame.Size = UDim2.new(1, -120, 1, -50)
    ContentFrame.Position = UDim2.new(0, 115, 0, 45)
    ContentFrame.BackgroundColor3 = UISettings.SurfaceContainerHigh
    ContentFrame.BackgroundTransparency = UISettings.SurfaceElevation
    ContentFrame.Parent = MainFrame
    
    -- Add subtle stroke to ContentFrame
    local ContentStroke = Instance.new("UIStroke")
    ContentStroke.Color = UISettings.OutlineColor
    ContentStroke.Transparency = 0.8
    ContentStroke.Thickness = 1
    ContentStroke.Parent = ContentFrame
    
    local ContentCorner = Instance.new("UICorner")
    ContentCorner.CornerRadius = UISettings.CornerRadius
    ContentCorner.Parent = ContentFrame
    
    -- Coming Soon Label with Material You 3 typography
    local ComingSoonLabel = Instance.new("TextLabel")
    ComingSoonLabel.Name = "ComingSoonLabel"
    ComingSoonLabel.Size = UDim2.new(1, -32, 0, 36)
    ComingSoonLabel.Position = UDim2.new(0, 16, 0, 16)
    ComingSoonLabel.BackgroundTransparency = 1
    ComingSoonLabel.Text = "Coming Soon!"
    ComingSoonLabel.TextColor3 = UISettings.TextColor
    ComingSoonLabel.TextSize = 16
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
        ButtonContainer.Size = UDim2.new(0.9, 0, 0, 36)
        ButtonContainer.Position = UDim2.new(0.05, 0, 0, currentY)
        ButtonContainer.BackgroundColor3 = UISettings.ButtonColor
        ButtonContainer.BackgroundTransparency = UISettings.SurfaceElevation
        ButtonContainer.Parent = NavBar
        
        -- Add subtle stroke to buttons
        local ButtonStroke = Instance.new("UIStroke")
        ButtonStroke.Color = UISettings.OutlineColor
        ButtonStroke.Transparency = 0.8
        ButtonStroke.Thickness = 1
        ButtonStroke.Parent = ButtonContainer
        
        local ButtonCorner = Instance.new("UICorner")
        ButtonCorner.CornerRadius = UDim.new(0, 8)
        ButtonCorner.Parent = ButtonContainer
        
        local Button = Instance.new("TextButton")
        Button.Name = buttonText .. "Button"
        Button.Size = UDim2.new(1, 0, 1, 0)
        Button.Position = UDim2.new(0, 0, 0, 0)
        Button.BackgroundTransparency = 1
        Button.Text = buttonText
        Button.TextColor3 = UISettings.TextColor
        Button.TextSize = 14
        Button.Font = UISettings.FontFamily
        Button.Parent = ButtonContainer
        
        -- Enhanced Button Functionality with Material You 3 state changes
        Button.MouseButton1Click:Connect(function()
            clearContentFrame()
            ComingSoonLabel.Text = buttonText .. " - Coming Soon!"
            
            -- Update all buttons to default state
            for _, otherButton in ipairs(NavBar:GetChildren()) do
                if otherButton:IsA("Frame") and otherButton.Name:find("Container") then
                    otherButton.BackgroundColor3 = UISettings.ButtonColor
                    otherButton.BackgroundTransparency = UISettings.SurfaceElevation
                end
            end
            
            -- Apply selected state
            ButtonContainer.BackgroundColor3 = UISettings.HighlightColor
            ButtonContainer.BackgroundTransparency = 0
            TweenService:Create(Button, TweenInfo.new(0.3), {
                TextColor3 = Color3.fromRGB(255, 255, 255)
            }):Play()
        end)
        
        -- Enhanced Hover Effects
        ButtonContainer.MouseEnter:Connect(function()
            if ButtonContainer.BackgroundColor3 ~= UISettings.HighlightColor then
                TweenService:Create(ButtonContainer, TweenInfo.new(0.2), {
                    BackgroundTransparency = UISettings.HoverElevation,
                    BackgroundColor3 = UISettings.SurfaceContainerHigh
                }):Play()
            end
        end)
        
        ButtonContainer.MouseLeave:Connect(function()
            if ButtonContainer.BackgroundColor3 ~= UISettings.HighlightColor then
                TweenService:Create(ButtonContainer, TweenInfo.new(0.2), {
                    BackgroundTransparency = UISettings.SurfaceElevation,
                    BackgroundColor3 = UISettings.ButtonColor
                }):Play()
            end
        end)
        
        currentY = currentY + 40 + 4  -- Increased spacing for better touch targets
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
            
            -- Smooth minimize animation
            TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = UDim2.new(0, 450, 0, 40)
            }):Play()
        else
            -- Smooth restore animation
            TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = originalSize
            }):Play()
            
            -- Wait for animation to complete before showing content
            wait(0.2)
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
