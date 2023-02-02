function InstructionalButton(controlButton, text)
    ScaleformMovieMethodAddParamPlayerNameString(controlButton)
    BeginTextCommandScaleformString("STRING")
    AddTextComponentSubstringKeyboardDisplay(text)
    EndTextCommandScaleformString()
end