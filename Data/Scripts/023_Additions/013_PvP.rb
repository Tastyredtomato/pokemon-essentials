################################################################################
# PvP Script
# By Hansiec
# Credits Required
################################################################################
# NOTICE: By PvP this does NOT really mean player vs player, it's more like
#         player vs other player's party controlled by an AI.
#
# To use:
#   * Create a folder in your game's folder called "Trainers" (otherwise there
#       WILL be errors)
#   * Call "PVP.open"
#
################################################################################

class TrainerPackage
  attr_accessor :trainer
  attr_accessor :start_speech
  attr_accessor :lose_speech
  attr_accessor :win_speech
  attr_accessor :game_code
end

module PVP
  def self.open
    loop do
      commands = []
      commands[cmdDump=commands.length] = "Create Trainer Data"
      commands[cmdBattle=commands.length] = "Battle a Trainer"
      commands[cmdExit=commands.length] = "Exit"
      choice = Kernel.pbMessage(_INTL("Welcome to the PVP station, how may I help you?"),
      commands, 0, nil, 0)
      if choice == cmdDump
        if PVPCore.createTrainerFile
          Kernel.pbMessage(_INTL("Successfully made trainer data to: Trainers/#{$Trainer.name}'s Trainer.tpk"))
        else
          Kernel.pbMessage(_INTL("Could not make trainer data"))
        end
      elsif choice == cmdBattle
        files = ["Cancel"]
        Dir.chdir("Trainers"){
          Dir.glob("*.tpk"){|f|
            files.push(f)
          }
        }
        choice = Kernel.pbMessage(_INTL("select a trainer file"), files, -1, nil, 0)
        if choice >= 1
          file = "Trainers/" + files[choice]
          trainer = PVPCore.loadTrainer(file)
          if trainer
            PVPCore.battleTrainer(trainer)
          else
            Kernel.pbMessage(_INTL("Cannot load trainer file..."))
          end
        end
      elsif choice == cmdExit
        break
      end
    end
  end


module PVPCore
  # Pokemon that cannot, no matter what be accepted.
  BLACK_LIST = [
    :MEWTWO,
    :MEW,
    :HOOH,
    :LUGIA,
    :CELEBI,
    :KYOGRE,
    :GROUDON,
    :RAYQUAZA,
    :DEOXYS,
    :JIRACHI
  ]
  
  def self.partyEligible?(party=$Trainer.party)
    for i in party
      if BLACK_LIST.include?(i.species) || i.egg?
        return false
      end
    end
    return true
  end
  
  def self.getBannedPokemonString
    string = PBSpecies.getName(BLACK_LIST[0])
    for i in 1...BLACK_LIST.length-1
      string += ", " + PBSpecies.getName(BLACK_LIST[i])
    end
    string += ", and " + PBSpecies.getName(BLACK_LIST[BLACK_LIST.length - 1])
  end
  
  def self.createTrainerFile
    pre=Kernel.pbMessageFreeText("Enter the speech for when you are challenged", "Battle me, Now!", false, 256)
    win=Kernel.pbMessageFreeText("Enter the speech for when you win", "I win!", false, 256)
    lose=Kernel.pbMessageFreeText("Enter the speech for when you lost", "I Lost...", false, 256)
    return dumpTrainer(pre, win, lose)
  end
    
  def self.dumpTrainer(pre, win, lose)
    f = File.open("Game.ini")
    lines = f.readlines()
    s = lines[3]
    len = s.size
    title = (s[6,len - 7])
    f.close
    if !partyEligible?
      Kernel.pbMessage(_INTL("Sorry, but the trainer file could not be created.\n"+
      "This may be because you have a banned pokemon or an egg in your party."+
      "\n Banned Pokemon Are: "+getBannedPokemonString + "."))
      return false
    end
    tp = TrainerPackage.new
    tp.trainer = $Trainer
    tp.game_code = title
    tp.start_speech = pre
    tp.win_speech = win
    tp.lose_speech = lose
    save_data(tp, "Trainers/#{$Trainer.name}'s Trainer.tpk")
    return true
  rescue
    return nil
  end
  
  def self.loadTrainer(file)
    f = File.open("Game.ini")
    lines = f.readlines()
    s = lines[3]
    len = s.size
    title = (s[6,len - 7])
    f.close
    tp = load_data(file)
    return false if tp.game_code != title
    return [tp.trainer, tp.start_speech, tp.lose_speech, tp.win_speech]
  rescue
    return nil
  end
  
  def self.battleTrainer(file)
    trainer = file
    trainer = loadTrainer(file) if !file.is_a?(Array)
    return false if !trainer
    Kernel.pbMessage(_INTL(trainer[1]))
    return pbOrganizedBattleEx(trainer[0],nil,trainer[2],trainer[3])
  end
  
end
end
