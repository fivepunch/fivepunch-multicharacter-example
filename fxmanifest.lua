fx_version 'cerulean'
game { 'gta5' }

title 'Example script'
description 'Example script to consume the Fivepunch character selection API.'
author 'Fivepunch https://fivepunch.io'
version '1.0.0'

lua54 'yes'

client_script {
    '@fivepunch-character-selection/lib/class.lua',
    '@fivepunch-character-selection/lib/stateMachine.lua',
    'client/states/selectingState.lua',
    'client/states/deletingState.lua',
    'client/main.lua'
}

dependencies {
    'fivepunch-character-selection'
}
