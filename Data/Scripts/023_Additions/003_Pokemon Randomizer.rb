################################################################################
# Randomized Pokemon Script
# By Umbreon
################################################################################
# Used for a randomized pokemon challenge mainly.
# 
# By randomized, I mean EVERY pokemon will be random, even interacted pokemon
#   like legendaries. (You may easily disable the randomizer for certain
#    situations like legendary battles and starter selecting.)
#
# To use: simply activate Switch Number X
#  (X = the number listed After "Switch = ", default is switch number 36.)
#
# If you want certain pokemon to NEVER appear, add them inside the black list.
#  (This does not take into effect if the switch stated above is off.)
#
# If you want ONLY certain pokemon to appear, add them to the whitelist. This
#   is only recommended when the amount of random pokemon available is around
#   32 or less.(This does not take into effect if the switch stated above is off.)
#
################################################################################

########################## You may edit any settings below this freely.
module RandomizedChallenge
  Switch = 60 # switch ID to randomize a pokemon, if it's on then ALL
              # pokemon will be randomized. No exceptions.
                        
  BlackListedPokemon = [
    :EGGCARD,
    :ALEXANDRINACARD,
    :CONRADCARD,
    :RANGERCARD,
    :ROBOMEWTWOCARD,
    :MARIUSCARD,
    :JUBILEECARD,
    :POPLARCARD,
    :DADCARD,
    :MOMCARD
  ]
  # Pokemon to Black List. Any pokemon in here will NEVER appear.
  
  WhiteListedPokemon = []
  # Leave this empty if all pokemon are allowed, otherwise only pokemon listed
  # above will be selected.
end

######################### Do not edit anything below here.
class PokeBattle_Pokemon
  
  alias randomized_init initialize
  
  def initialize(species,level,player=nil,withMoves=true)
    
    if $game_switches && $game_switches[RandomizedChallenge::Switch]
      species = RandomizedChallenge::WhiteListedPokemon.shuffle[0]
      if RandomizedChallenge::WhiteListedPokemon.length == 0
        species = rand(PBSpecies.maxValue - 1) + 1
        while RandomizedChallenge::BlackListedPokemon.include?(species)
          species = rand(PBSpecies.maxValue - 1) + 1
        end
      end
    end
    
    randomized_init(species, level, player, withMoves)
  end
end