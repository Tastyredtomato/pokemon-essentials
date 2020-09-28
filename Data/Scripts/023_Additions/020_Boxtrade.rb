#=========================================================
#     Trade From Box
#        by mej71
#
# https://www.pokecommunity.com/showthread.php?t=360077
#
#
#Changes by derFischae:
#bug fixes and including BoxExchange (written by Jonas930)
# https://www.pokecommunity.com/showthread.php?p=10109075
#=========================================================
#This script can be utilized to initiate trades that allow you to choose
#a pokemon from your PC or party to trade, rather than just your party.
#
#Installation:
#-Add this script in a separate section above the main (and below the PScreen_Stroage)
#-Make sure to also include the Script BOXEXCHANGE by Jonas930 to your project or
# replace the code
#   $PokemonStorage.pbDelete(poke[0],poke[1])
#   pbStorePokemon(yourPokemon)
# by
#   $PokemonStorage[poke[0]][poke[1]]=yourPokemon
# at the end of method "pbTradeFromPC".
#
#How to Use:
#To call, simply make an event with something like this
#(This is trading a Kindra for a female Dragonair):
#
#pbTradeFromPC(:KINGDRA,35,"Fred",0,nil,proc {|poke|
# !poke.isEgg? &&
# !(poke.isShadow? rescue false) &&
# poke.gender==1 &&
# poke.species==PBSpecies::DRAGONAIR
#})
#=========================================================
 

def pbTradeFromPC(tradepoke,tradelevel,trainerName,trainerGender,nickname=nil,ableProc=nil)
  opponent=PokeBattle_Trainer.new(trainerName,trainerGender)
  opponent.setForeignID($Trainer)
  yourPokemon=nil
  if tradepoke.is_a?(PokeBattle_Pokemon)
    tradepoke.trainerID=opponent.id
    tradepoke.ot=opponent.name
    tradepoke.otgender=opponent.gender
    tradepoke.language=opponent.language
    yourPokemon=tradepoke
  else
    if tradepoke.is_a?(String) || tradepoke.is_a?(Symbol)
      raise _INTL("Species does not exist ({1}).",tradepoke) if !hasConst?(PBSpecies,tradepoke)
      tradepoke=getID(PBSpecies,tradepoke)
    end
    yourPokemon=PokeBattle_Pokemon.new(tradepoke,tradelevel,opponent)
  end
  yourPokemon.name=nickname if nickname!=nil
  yourPokemon.resetMoves
  yourPokemon.obtainMode=2 # traded
  scene=PokemonStorageScene.new
  screen=PokemonStorageScreen.new(scene,$PokemonStorage)
  poke=screen.pbChooseTradePoke(yourPokemon,ableProc)
  if poke==nil
    return false
  end
  #Trading Scene
  myPokemon=$PokemonStorage[poke[0]][poke[1]]
  $Trainer.seen[yourPokemon.species]=true
  $Trainer.owned[yourPokemon.species]=true
  pbSeenForm(yourPokemon)
  yourPokemon.pbRecordFirstMoves
  pbFadeOutInWithMusic(99999){
    evo=PokemonTrade_Scene.new
    evo.pbStartScreen(myPokemon,yourPokemon,$Trainer.name,opponent.name)
    evo.pbTrade
    evo.pbEndScreen
  }
  #=============================================
  # changes by derFischae to include message 
  # if you prefer to use Species-Names:
  #Kernel.pbMessage(_INTL("{1} traded {2} for {3}!",$Trainer.name,PBSpecies.getName(myPokemon.species),PBSpecies.getName(yourPokemon.species)))
  # if you prefer the nicknames:
  Kernel.pbMessage(_INTL("{1} traded {2} for {3}!",$Trainer.name,myPokemon.name,yourPokemon.name))
  #=============================================
  # changes by derFischae to include BoxExchange to Trades
  $PokemonStorage[poke[0]][poke[1]]=yourPokemon
  # end of changes
  #=============================================
  # original code:
  #$PokemonStorage[poke[0]][poke[1]]=yourPokemon
  #=============================================
  return true
end

class PokemonStorageScreen
  
################################################################################
##Choose Pokemon for trading
################################################################################
  def pbChooseTradePoke(tradepoke,ableProc)
  @heldpkmn=nil
    #@scene.pbStartBox(self,2)
    #zum Testen geaendert
    @scene.pbStartBox(self,0)
    retval=nil
    loop do
      selected=@scene.pbSelectBox(@storage.party)
      if selected && selected[0]==-3 # Close box
        if pbConfirm(_INTL("Exit from the Box?"))
          break
        else
          next
        end
      end
      if selected==nil
        if pbConfirm(_INTL("Continue Box operations?"))
          next
        else
          break
        end
      elsif selected[0]==-4 # Box name
        pbBoxCommands
      else
        pokemon=@storage[selected[0],selected[1]]
        next if !pokemon
        commands=[
          _INTL("Select"),
          _INTL("Summary"),
          _INTL("Cancel")
        ]
        helptext=_INTL("Trade this Pokémon for {1}?",PBSpecies.getName(tradepoke.species))
        command=pbShowCommands(helptext,commands)
        case command
          when 0 # Move/Shift/Place
            if pokemon
              if ableProc==nil || ableProc.call(pokemon)
                retval=selected
                break
              else
                pbDisplay(_INTL("This Pokémon can't be chosen."))
              end
            end
          when 1 # Summary
            pbSummary(selected,nil)
          when 2
            retval=nil
            next
        end
      end
    end
    @scene.pbCloseBox
    return retval
  end
end