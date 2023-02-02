DeletingState = Class { __includes = State }

local Selection = exports['fivepunch-character-selection']

function DeletingState:init()
    self.transitioning = false

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
    InstructionalButton(GetControlInstructionalButton(1, 194, false), "Return to selecting")
    EndScaleformMovieMethod()

    BeginScaleformMovieMethod(self.scaleform, "SET_DATA_SLOT")
    ScaleformMovieMethodAddParamInt(2)
    InstructionalButton(GetControlInstructionalButton(1, 18, false), "Delete character")
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
        print('Character ' .. character.name .. ' deleted!')

        self.transitioning = true

        Selection:flipTheBird(character, function()
            self.transitioning = false

            Selection:deleteCharacter(character)
            Selection:setSelecting()
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

function DeletingState:enter(params)
end

function DeletingState:update()
    if self.transitioning then return end

    -- You should use keymappings instead of this on your server.

    if IsDisabledControlJustPressed(0, 202) then -- Backspace
        gStateMachine:change('selecting')
    end

    DrawScaleformMovieFullscreen(self.scaleform, 255, 255, 255, 255, 0)
end

function DeletingState:exit()
    self.shouldUpdate = false
end
