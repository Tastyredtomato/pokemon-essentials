###############################################################################
# TRADE STONE NPC by TastyRedTomato
# ------------------------------
# please credit when used
# To use: 
#   * Create an item called TRADESTONE in the PBS Items.txt, distribute it as desired
#   * Add the pokemon who evolve by trading to the TradeList 
#    (you still need to define their evolution method in pokemon.txt)
#   * Create an npc event which runs pbTradeStone
#
###############################################################################
TradeList = [
      64, #kadabra
      67, #machoke
      75, #graveler
      93, #haunter
      61, #poliwhirl
      79, #slowpoke
      95, #onix
      123, #scyther
      117, #seadra
      137, #porygon
      366, #clamperl
      349 #feebas
      ]

def pbTradeStone
  Kernel.pbMessage(_INTL("Have you heard of the Trade Stone? It's a rare evolution stone that affects Pokémon that are usually evolved through trading."))
  commands = []
      commands[cmdEvo=commands.length] = "Use a Trade Stone"
      commands[cmdExit=commands.length] = "Exit"
      choice = Kernel.pbMessage(_INTL("Would you like to use a Trade Stone?"),
      commands, 0, nil, 0)
  if choice == cmdEvo
     if $PokemonBag.pbHasItem?(:TRADESTONE)
      pbChooseTradablePokemon(1,3)
      pkmn = $Trainer.party[$game_variables[1]]
      if $game_variables[1] == -1
        Kernel.pbMessage(_INTL("You didn't select a valid Pokémon."))
        return
      elsif TradeList.include?(pkmn.species)
        Kernel.pbMessage(_INTL("The Trade Stone shines brightly."))
        newspecies = pbTradeCheckEvolution($Trainer.party[$game_variables[1]], $Trainer.party[$game_variables[1]].item)
        if newspecies > 0
          evo = PokemonEvolutionScene.new
          evo.pbStartScreen(pkmn, newspecies)
          evo.pbEvolution
          evo.pbEndScreen
          $PokemonBag.pbDeleteItem(:TRADESTONE)
        else
          Kernel.pbMessage(_INTL("Your Pokémon failed to evolve."))
        end
        return
      else
        Kernel.pbMessage(_INTL("This pokemon does not evolve through trading."))
        return
      end
      
    else
     Kernel.pbMessage(_INTL("It seems you're missing a Trade Stone.")) 
     return
    end
    
  elsif choice == cmdExit
   Kernel.pbMessage(_INTL("Very well, have a nice day."))
   return
  end
end

  