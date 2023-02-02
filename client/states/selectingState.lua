SelectingState = Class { __includes = State }

local Selection = exports['fivepunch-character-selection']

function SelectingState:init()
    self.scaleform = RequestScaleformMovie("instructional_buttons")

    while not HasScaleformMovieLoaded(self.scaleform) do
        Wait(0)
    end

    BeginScaleformMovieMethod(self.scaleform, "CLEAR_ALL")
    EndScaleformMovieMethod()

    BeginScaleformMovieMethod(self.scaleform, "SET_CLEAR_SPACE")
    ScaleformMovieMethodAddParamInt(200)
    EndScaleformMovieMethod()

    BeginScaleformMovieMethod(self.scaleform, "SET_DATA_SLOT")
    ScaleformMovieMethodAddParamInt(1)
    InstructionalButton(GetControlInstructionalButton(1, 194, false), "Exit character selection")
    EndScaleformMovieMethod()

    BeginScaleformMovieMethod(self.scaleform, "SET_DATA_SLOT")
    ScaleformMovieMethodAddParamInt(2)
    InstructionalButton(GetControlInstructionalButton(1, 307, false), "Next page")
    EndScaleformMovieMethod()

    BeginScaleformMovieMethod(self.scaleform, "SET_DATA_SLOT")
    ScaleformMovieMethodAddParamInt(3)
    InstructionalButton(GetControlInstructionalButton(1, 308, false), "Previous page")
    EndScaleformMovieMethod()

    BeginScaleformMovieMethod(self.scaleform, "SET_DATA_SLOT")
    ScaleformMovieMethodAddParamInt(4)
    InstructionalButton(GetControlInstructionalButton(1, 256, false), "Delete character")
    EndScaleformMovieMethod()

    BeginScaleformMovieMethod(self.scaleform, "SET_DATA_SLOT")
    ScaleformMovieMethodAddParamInt(5)
    InstructionalButton(GetControlInstructionalButton(1, 18, false), "Select character")
    EndScaleformMovieMethod()


    BeginScaleformMovieMethod(self.scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
    EndScaleformMovieMethod()

    BeginScaleformMovieMethod(self.scaleform, "SET_BACKGROUND_COLOUR")
    ScaleformMovieMethodAddParamInt(0)
    ScaleformMovieMethodAddParamInt(0)
    ScaleformMovieMethodAddParamInt(0)
    ScaleformMovieMethodAddParamInt(80)
    EndScaleformMovieMethod()

    Selection:onCharacterSelect(function(character)
        print('Character ' .. character.name .. ' selected!')

        gStateMachine:done() -- No need to transitioning flag

        Selection:flipTheBird(character, function()
            Selection:deleteCharacter(character)
            Selection:setOutOfCharacterSelection()
        end)
    end)

    self.shouldUpdate = true

    CreateThread(function()
        while self.shouldUpdate do
            self:update()
            Wait(0)
        end
    end)
end

function SelectingState:enter(params)
end

function SelectingState:update()
    -- You should use keymappings instead of this on your server.

    if IsDisabledControlJustPressed(0, 202) then -- ESC
        gStateMachine:done()
        Selection:setOutOfCharacterSelection()
    elseif IsDisabledControlJustPressed(0, 189) then -- Left arrow
        Selection:previousPage()
    elseif IsDisabledControlJustPressed(0, 190) then -- Right arrow
        Selection:nextPage()
    elseif IsDisabledControlJustPressed(0, 214) then -- Delete
        gStateMachine:change('deleting')
    end

    DrawScaleformMovieFullscreen(self.scaleform, 255, 255, 255, 255, 0)
end

function SelectingState:exit()
    self.shouldUpdate = false
end
