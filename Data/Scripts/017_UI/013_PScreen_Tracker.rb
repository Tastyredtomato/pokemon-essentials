class PokemonTracker_Scene
  def pbUpdate
    pbUpdateSpriteHash(@sprites)
  end

  def pbStartScene(commands)
    @commands = commands
    @viewport = Viewport.new(0,0,Graphics.width,Graphics.height)
    @viewport.z = 99999
    @sprites = {}
    @sprites["background"] = IconSprite.new(0,0,@viewport)
    @sprites["background"].setBitmap("Graphics/Pictures/trackerbg")
    @sprites["header"] = Window_UnformattedTextPokemon.newWithSize(
       _INTL("PokéTracker"),2,-18,256,64,@viewport)
    @sprites["header"].baseColor   = Color.new(248,248,248)
    @sprites["header"].shadowColor = Color.new(0,0,0)
    @sprites["header"].windowskin  = nil
    @sprites["commands"] = Window_CommandPokemon.newWithSize(@commands,
       94,92,324,224,@viewport)
    @sprites["commands"].windowskin = nil
    pbFadeInAndShow(@sprites) { pbUpdate }
  end

  def pbScene
    ret = -1
    loop do
      Graphics.update
      Input.update
      pbUpdate
      if Input.trigger?(Input::B)
        break
      elsif Input.trigger?(Input::C)
        ret = @sprites["commands"].index
        break
      end
    end
    return ret
  end

  def pbSetCommands(newcommands,newindex)
    @sprites["commands"].commands = (!newcommands) ? @commands : newcommands
    @sprites["commands"].index    = newindex
  end

  def pbEndScene
    pbFadeOutAndHide(@sprites) { pbUpdate }
    pbDisposeSpriteHash(@sprites)
    @viewport.dispose
  end
end



class PokemonTrackerScreen
  def initialize(scene)
    @scene = scene
  end

  def pbStartScreen
    commands = []
    cmdScan   = -1
    commands[cmdScan = commands.length]   = _INTL("Training Scan")
    commands[cmdRoam = commands.length]   = _INTL("Roaming Scan")
    commands[cmdTask = commands.length]   = _INTL("Task Reports")
    commands[cmdLib = commands.length]   = _INTL("Library")
    commands[commands.length]              = _INTL("Exit")
    @scene.pbStartScene(commands)
    loop do
      cmd = @scene.pbScene
      if cmd<0
        pbPlayCancelSE
        break
      elsif cmdScan>=0 && cmd==cmdScan
        pbPlayDecisionSE
        Kernel.pbMessage(_INTL("Scanning for Pokémon of equal strength..."))
        #List locations here per level interval
        if $Trainer.party[0].level >=1 && $Trainer.party[0].level < 10 #Level-10
          Kernel.pbMessage(_INTL("4 results found."))
          Kernel.pbMessage(_INTL("Route 1, Bell Lake, Route 2, Route 3"))
        elsif $Trainer.party[0].level >=10 && $Trainer.party[0].level < 20 #Level0-20
          Kernel.pbMessage(_INTL("7 results found."))
          Kernel.pbMessage(_INTL("Route 3, Bell Town Belfry, The Great Dam, Hedge Point, Hedge Weald, Route 4, Yssel Lake"))
        elsif $Trainer.party[0].level >=20 && $Trainer.party[0].level < 30 #Leve20-30
          Kernel.pbMessage(_INTL("2 results found."))
          Kernel.pbMessage(_INTL("Route 5, Harrow's Descent"))
        else
          Kernel.pbMessage(_INTL("No results found."))
        end
      elsif cmdRoam>=0 && cmd==cmdRoam
        pbPlayDecisionSE
        Kernel.pbMessage(_INTL("Scanning for Roaming Pokémon..."))
        if $game_switches[55] == true || $game_switches[82] == true || $game_switches[83] == true#add switches for roaming mons
          Kernel.pbMessage(_INTL("Data Found!"))
          if $game_switches[55] == true
            Kernel.pbMessage(_INTL("The Pokémon Entei was last seen in:"))
            Kernel.pbMessage(pbcheckRoaming(0))
          end
          if $game_switches[82] == true
            Kernel.pbMessage(_INTL("The Pokémon Suicune was last seen in:"))
            Kernel.pbMessage(pbcheckRoaming(1))
          end
          if $game_switches[83] == true
            Kernel.pbMessage(_INTL("The Pokémon Raikou was last seen in:"))
            Kernel.pbMessage(pbcheckRoaming(2))
          end
        else
          Kernel.pbMessage(_INTL("No Data was found."))
        end
      elsif cmdTask>=0 && cmd==cmdTask
        pbPlayDecisionSE
        Kernel.pbMessage(_INTL("Fetching Reports..."))
        pbQuestlog
      elsif cmdLib>=0 && cmd==cmdLib
        pbPlayDecisionSE
        Kernel.pbMessage(_INTL("Loading Library..."))
        pbBooklog
      else   # Exit
        pbPlayDecisionSE
        break
      end
    end
    @scene.pbEndScene
  end
end