from ConfigContents import GameInfo


GRIDSIZE = 36

p1filepath = 'boatplacement_P1.cfg'
p2filepath = 'boatplacement_P2.cfg'

P1 = GameInfo(p1filepath)
P2 = GameInfo(p2filepath)

# Determine Hit P1 Ships
for i in range(0, GRIDSIZE):
    if P2.targets[i] == '1' and P1.ships[i] != '0':
        P1.ships[i] = '5' + P1.ships[i]
        P1.msg[i] = '"X"'
        P2.targets[i] = '3'
    elif P2.targets[i] == '1' and P1.ships[i] == '0':
        P2.targets[i] = '2'

# Determine Hit P2 Ships
for i in range(0, GRIDSIZE):
    if P1.targets[i] == '1' and P2.ships[i] != '0':
        P2.ships[i] = '5' + P2.ships[i]
        P2.msg[i] = '"X"'
        P1.targets[i] = '3'
    elif P1.targets[i] == '1' and P2.ships[i] == '0':
        P1.targets[i] = '2'

# Prints messages
msg = P1.getMsg("aircraft")
print(f"Player 1 Aircraft Carrier Message: ", msg)
msg = P1.getMsg("cruiser")
print(f"Player 1 Cruiser Message: ", msg)
msg = P1.getMsg("submarine")
print(f"Player 1 Submarine Message: ", msg)
msg = P1.getMsg("destroyer")
print(f"Player 1 Destroyer Carrier Message: ", msg)

msg = P2.getMsg("aircraft")
print(f"Player 2 Aircraft Carrier Message: ", msg)
msg = P2.getMsg("cruiser")
print(f"Player 2 Cruiser Message: ", msg)
msg = P2.getMsg("submarine")
print(f"Player 2 Submarine Message: ", msg)
msg = P2.getMsg("destroyer")
print(f"Player 2 Destroyer Carrier Message: ", msg)

# Update Config Files Ships, Targets, and msg sections
#P1.updateFile()
#P2.updateFile()
