from configparser import ConfigParser

GRIDSIZE = 36
ConfigFilePath = r"C:\Users\yayab.DESKTOP1\Documents\boatplacement_P1.cfg"

cfg = ConfigParser()

# Read in Player 1 Config File
cfg.read('boatplacement_P1.cfg')
stateP1 = cfg.get("Player", "State")
shipsP1 = cfg.get("Positions", "Ships")
targetsP1 = cfg.get("Positions", "Targets")
msgP1 = cfg.get("Messages", "msg")

# Read in Player 2 Config File
cfg.read('boatplacement_P2.cfg')
stateP2 = cfg.get("Player", "State")
shipsP2 = cfg.get("Positions", "Ships")
targetsP2 = cfg.get("Positions", "Targets")
msgP2 = cfg.get("Messages", "msg")

# Turn strings into lists
shipsP1 = shipsP1.strip(' ][ ').split(', ')
shipsP2 = shipsP2.strip(' ][ ').split(', ')
targetsP2 = targetsP2.strip(' ][ ').split(', ')
targetsP1 = targetsP1.strip(' ][ ').split(', ')

# Compare Player 1 and PLayer 2 Config Files
for i in range(0, GRIDSIZE-1):
    if targetsP2[i] == '1' and shipsP1[i] != '0':
        shipsP1[i] = '5' + shipsP1[i]
        targetsP2[i] = '3'
    elif targetsP2[i] == '1' and shipsP1[i] == '0':
        targetsP2[i] = '2'
    else:
        'Error in Config File'

for i in range(0, GRIDSIZE-1):
    if targetsP1[i] == '1' and shipsP2[i] != '0':
        shipsP2[i] = '5' + shipsP2[i]
        targetsP1[i] = '3'
    elif targetsP1[i] == '1' and shipsP2[i] == '0':
        targetsP1[i] = '2'
    else:
        'Error in Config File'

# Reformat lists back into original strings
shipsP1 = '[ ' + ', '.join(shipsP1) + ' ]'
shipsP2 = '[ ' + ', '.join(shipsP2) + ' ]'
targetsP1 = '[ ' + ', '.join(targetsP1) + ' ]'
targetsP2 = '[ ' + ', '.join(targetsP2) + ' ]'

# Write to Player 2 Config file
cfg.set("Positions", "Ships", shipsP2)
cfg.set("Positions", "Targets", targetsP2)
with open('boatplacement_P2.cfg', 'w') as configfile:
    cfg.write(configfile)

# Write to Player 1 Config File
cfg.read('boatplacement_P1.cfg')

cfg.set("Positions", "Ships", shipsP1)
cfg.set("Positions", "Targets", targetsP1)

with open('boatplacement_P1.cfg', 'w') as configfile:
    cfg.write(configfile)
