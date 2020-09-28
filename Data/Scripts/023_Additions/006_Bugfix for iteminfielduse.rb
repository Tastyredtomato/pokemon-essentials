#####################################################################
# Bug-Fixes by derFischae
#
# Installation: Copy & paste this Script in a new Script above main
#####################################################################

#####################################################################
# Well just for replacing HMs with Items you can simply add
#                     $game_temp.in_menu = false
# at the beginning of the methods  useMoveCut, useMoveRockSmash, ... 
# instead of using this bug fix. But infact this bug fix is also useful for fishing, etc.
#####################################################################

#####################################################################
# Replacing the method pbStartReadyMenu in class PokemonReadyMenu in 
# Script PScreen_ReadyMenu to fix a bug.
# The bug is the following: While using an item in the ready menu the flag $game_temp.in_menu
# is not set to false. Hence all events including there animations are frozen. This is especially 
# annoying if you want to replace rocksmash with an item, but you won't get the smash animation.
#####################################################################
class PokemonReadyMenu
  def pbStartReadyMenu(moves,items)
    commands = [[],[]] # Moves, items
    for i in moves
      commands[0].push([i[0],PBMoves.getName(i[0]),true,i[1]])
    end
    commands[0].sort!{|a,b| a[1]<=>b[1]}
    for i in items
      commands[1].push([i,PBItems.getName(i),false])
    end
    commands[1].sort!{|a,b| a[1]<=>b[1]}
    
    @scene.pbStartScene(commands)
    loop do
      command = @scene.pbShowCommands
      if command==-1
        break
      else
        if command[0]==0 # Use a move
          move = commands[0][command[1]][0]
          user = $Trainer.party[commands[0][command[1]][3]]
          if isConst?(move,PBMoves,:FLY)
            ret = nil
            pbFadeOutInWithUpdate(99999,@scene.sprites){
              pbHideMenu
              scene = PokemonRegionMap_Scene.new(-1,false)
              screen = PokemonRegionMapScreen.new(scene)
              ret = screen.pbStartFlyScreen
              pbShowMenu if !ret
            }
            if ret
              $PokemonTemp.flydata = ret
              $game_temp.in_menu = false
              Kernel.pbUseHiddenMove(user,move)
              break
            end
          else
            pbHideMenu
            if Kernel.pbConfirmUseHiddenMove(user,move)
              $game_temp.in_menu = false
              Kernel.pbUseHiddenMove(user,move)
              break
            else
              pbShowMenu
            end
          end
        else # Use an item
          item = commands[1][command[1]][0]
          pbHideMenu
          if ItemHandlers.triggerConfirmUseInField(item)
            ################################################
            # Here you gain the bug with UseInField in the Ready Menu
            # Changes by derFischae for bug fixing
            ################################################
            oldInMenu = $game_temp.in_menu
            $game_temp.in_menu = false
            break if Kernel.pbUseKeyItemInField(item)
            $game_temp.in_menu = oldInMenu
            ################################################
            # original code was:
            #break if Kernel.pbUseKeyItemInField(item)
            ################################################
            # ab hier alles wie zuvor
          end
        end
        pbShowMenu
      end
    end
    @scene.pbEndScene
  end
end




#####################################################################
# Replacing the method pbStartPokemonMenu in class PokemonPauseMenu
# in Script PScreen_PauseMenu to fix a bug.
# The bug is the following: While using an item in the bag the flag $game_temp.in_menu is not
# set to false. Hence all events including there animations are frozen. This is especially annoying
# if you want to replace rocksmash with an item, but you won't get the smash animation.
#####################################################################

class PokemonPauseMenu
  def pbStartPokemonMenu
    pbSetViableDexes
    @scene.pbStartScene
    endscene = true
    commands = []
    cmdPokedex  = -1
    cmdPokemon  = -1
    cmdBag      = -1
    cmdTrainer  = -1
    cmdSave     = -1
    cmdOption   = -1
    cmdPokegear = -1
    cmdDebug    = -1
    cmdQuit     = -1
    cmdEndGame  = -1
    if !$Trainer
      if $DEBUG
        Kernel.pbMessage(_INTL("The player trainer was not defined, so the menu can't be displayed."))
        Kernel.pbMessage(_INTL("Please see the documentation to learn how to set up the trainer player."))
      end
      return
    end
    commands[cmdPokedex = commands.length]  = _INTL("Pokédex") if $Trainer.pokedex && $PokemonGlobal.pokedexViable.length>0
    commands[cmdPokemon = commands.length]  = _INTL("Pokémon") if $Trainer.party.length>0
    commands[cmdBag = commands.length]      = _INTL("Bag") if !pbInBugContest?
    commands[cmdPokegear = commands.length] = _INTL("Pokégear") if $Trainer.pokegear
    commands[cmdTrainer = commands.length]  = $Trainer.name
    if pbInSafari?
      if SAFARISTEPS<=0
        @scene.pbShowInfo(_INTL("Balls: {1}",pbSafariState.ballcount))
      else
        @scene.pbShowInfo(_INTL("Steps: {1}/{2}\nBalls: {3}",
           pbSafariState.steps,SAFARISTEPS,pbSafariState.ballcount))
      end
      commands[cmdQuit = commands.length]   = _INTL("Quit")
    elsif pbInBugContest?
      if pbBugContestState.lastPokemon
        @scene.pbShowInfo(_INTL("Caught: {1}\nLevel: {2}\nBalls: {3}",
           PBSpecies.getName(pbBugContestState.lastPokemon.species),
           pbBugContestState.lastPokemon.level,
           pbBugContestState.ballcount))
      else
        @scene.pbShowInfo(_INTL("Caught: None\nBalls: {1}",pbBugContestState.ballcount))
      end
      commands[cmdQuit = commands.length]   = _INTL("Quit Contest")
    else
      commands[cmdSave = commands.length]   = _INTL("Save") if $game_system && !$game_system.save_disabled
    end
    commands[cmdOption = commands.length]   = _INTL("Options")
    commands[cmdDebug = commands.length]    = _INTL("Debug") if $DEBUG
    commands[cmdEndGame = commands.length]  = _INTL("Quit Game")
    loop do
      command = @scene.pbShowCommands(commands)
      if cmdPokedex>=0 && command==cmdPokedex
        if USE_CURRENT_REGION_DEX
          pbFadeOutIn(99999){
            scene = PokemonPokedex_Scene.new
            screen = PokemonPokedexScreen.new(scene)
            screen.pbStartScreen
            @scene.pbRefresh
          }
        else
          if $PokemonGlobal.pokedexViable.length==1
            $PokemonGlobal.pokedexDex = $PokemonGlobal.pokedexViable[0]
            $PokemonGlobal.pokedexDex = -1 if $PokemonGlobal.pokedexDex==$PokemonGlobal.pokedexUnlocked.length-1
            pbFadeOutIn(99999){
              scene = PokemonPokedex_Scene.new
              screen = PokemonPokedexScreen.new(scene)
              screen.pbStartScreen
              @scene.pbRefresh
            }
          else
            pbFadeOutIn(99999){
              scene = PokemonPokedexMenu_Scene.new
              screen = PokemonPokedexMenuScreen.new(scene)
              screen.pbStartScreen
              @scene.pbRefresh
            }
          end
        end
      elsif cmdPokemon>=0 && command==cmdPokemon
        hiddenmove = nil
        pbFadeOutIn(99999){ 
          sscene = PokemonParty_Scene.new
          sscreen = PokemonPartyScreen.new(sscene,$Trainer.party)
          hiddenmove = sscreen.pbPokemonScreen
          (hiddenmove) ? @scene.pbEndScene : @scene.pbRefresh
        }
        if hiddenmove
          $game_temp.in_menu = false
          Kernel.pbUseHiddenMove(hiddenmove[0],hiddenmove[1])
          return
        end
      elsif cmdBag>=0 && command==cmdBag
        item = 0
        pbFadeOutIn(99999){ 
          scene = PokemonBag_Scene.new
          screen = PokemonBagScreen.new(scene,$PokemonBag)
          item = screen.pbStartScreen 
          (item>0) ? @scene.pbEndScene : @scene.pbRefresh
        }
        if item>0
          ################################################
          # Here you gain the bug with UseInField in the Menu
          # Changes by derFischae for bug fixing
          ################################################
          oldInMenu = $game_temp.in_menu
          $game_temp.in_menu = false
          Kernel.pbUseKeyItemInField(item)
          $game_temp.in_menu = oldInMenu
          ################################################
          # Origina Code was:
          #Kernel.pbUseKeyItemInField(item)
          ################################################
          # ab hier alles wie zuvor
          return
        end
      elsif cmdPokegear>=0 && command==cmdPokegear
        pbFadeOutIn(99999){
          scene = PokemonPokegear_Scene.new
          screen = PokemonPokegearScreen.new(scene)
          screen.pbStartScreen
          @scene.pbRefresh
        }
      elsif cmdTrainer>=0 && command==cmdTrainer
        pbFadeOutIn(99999){ 
          scene = PokemonTrainerCard_Scene.new
          screen = PokemonTrainerCardScreen.new(scene)
          screen.pbStartScreen
          @scene.pbRefresh
        }
      elsif cmdQuit>=0 && command==cmdQuit
        @scene.pbHideMenu
        if pbInSafari?
          if Kernel.pbConfirmMessage(_INTL("Would you like to leave the Safari Game right now?"))
            @scene.pbEndScene
            pbSafariState.decision = 1
            pbSafariState.pbGoToStart
            return
          else
            pbShowMenu
          end
        else
          if Kernel.pbConfirmMessage(_INTL("Would you like to end the Contest now?"))
            @scene.pbEndScene
            pbBugContestState.pbStartJudging
            return
          else
            pbShowMenu
          end
        end
      elsif cmdSave>=0 && command==cmdSave
        @scene.pbHideMenu
        scene = PokemonSave_Scene.new
        screen = PokemonSaveScreen.new(scene)
        if screen.pbSaveScreen
          @scene.pbEndScene
          endscene = false
          break
        else
          pbShowMenu
        end
      elsif cmdOption>=0 && command==cmdOption
        pbFadeOutIn(99999){
          scene = PokemonOption_Scene.new
          screen = PokemonOptionScreen.new(scene)
          screen.pbStartScreen
          pbUpdateSceneMap
          @scene.pbRefresh
        }
      elsif cmdDebug>=0 && command==cmdDebug
        pbFadeOutIn(99999){
          pbDebugMenu
          @scene.pbRefresh
        }
      elsif cmdEndGame>=0 && command==cmdEndGame
        @scene.pbHideMenu
        if Kernel.pbConfirmMessage(_INTL("Are you sure you want to quit the game?"))
          scene = PokemonSave_Scene.new
          screen = PokemonSaveScreen.new(scene)
          if screen.pbSaveScreen
            @scene.pbEndScene
          end
          @scene.pbEndScene
          $scene = nil
          return
        else
          pbShowMenu
        end
      else
        break
      end
    end
    @scene.pbEndScene if endscene
  end
end