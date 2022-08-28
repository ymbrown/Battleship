from configparser import ConfigParser


class GameInfo:
    def __init__(self, filepath):
        self.cfg = ConfigParser()
        self.file = filepath
        self.cfg.read(filepath)
        self.state = self.setGameList("Player", "State")
        self.ships = self.setGameList("Positions", "Ships")
        self.targets = self.setGameList("Positions", "Targets")
        self.msg = self.setGameList("Messages", "msg")

    # Reformat data string into a list
    def setGameList(self, section, key):
        datastr = self.cfg.get(section, key)
        datalist = datastr.strip(' ][ ').split(', ')
        return datalist

    # Gets the message of a particular ship in a pretty format
    def getMsg(self, name):
        if name == "aircraft":
            num = '6'
        elif name == "cruiser":
            num = '4'
        elif name == "submarine":
            num = '3'
        elif name == "destroyer":
            num = '2'

        datalen = len(self.msg)
        msgstr = ''
        for i in range(0, datalen):
            if self.ships[i] == '5' + num or self.ships[i] == num:
                msgstr += self.msg[i]
        msgstr = msgstr.replace('"', '')
        return msgstr

    # sets config section with updated data
    def updateSection(self, section, key, datalist):
        updated_datastr = '[ ' + ', '.join(datalist) + ' ]'
        self.cfg.set(section, key, updated_datastr)

    # Writes all sections in Config File
    def updateFile(self):
        self.updateSection("Player", "State", self.state)
        self.updateSection("Positions", "Ships", self.ships)
        self.updateSection("Positions", "Targets", self.targets)
        self.updateSection("Messages", "msg", self.msg)
        with open(self.file, 'w') as configfile:
            self.cfg.write(configfile)
