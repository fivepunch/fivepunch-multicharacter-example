fx_version 'cerulean'
game { 'gta5' }

title 'Fivepunch multicharacter example'
description 'Example script to consume the Fivepunch multicharacter API.'
author 'Fivepunch https://fivepunch.io'
version '1.1.0'

lua54 'yes'

client_script {
    '@fivepunch-multicharacter/lib/class.lua',
    '@fivepunch-multicharacter/lib/stateMachine.lua',
    'client/instructionalButtons.lua',
    'client/states/selectingState.lua',
    'client/states/deletingState.lua',
    'client/main.lua'
}

dependencies {
    'fivepunch-multicharacter'
}
