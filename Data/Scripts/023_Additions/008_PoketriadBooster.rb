#===============================================================================
# * Triple Triad Booster Pack - by FL (Credits will be appreciated)
#===============================================================================
#
# This script is for Pokémon Essentials. It's a booster pack item for 
#
#===============================================================================
#
# To this script works, put it above main. Put an item into item.txt like:
#
# 712,BOOSTERPACK,Booster Pack,Booster Packs,1,500,An booster pack for Triple Triad game. Contains 3 cards ,2,0,0,
#
# You can set a BOOSTER_LIST lists. So, you can create several types of 
# packs. For helping in making these lists, this script includes a 
# method (getSpeciesOfType) that return the index of a pokémon type. An 
# example: if you call the line 'p getSpeciesOfType(PBTypes::DRAGON)', you can
# copy/paste the species array of all Dragon pokémon in pokemon.txt. If you
# copy into the index 2 (remember that the first index is 0), all that you need
# to do in the item script is:
#
# ItemHandlers::UseFromBag.add(:DRAGONPACK,proc{|item|
#   giveBoosterPack(item,3,2)
# })
#
# This script generates random cards, but generate some cards in order to a
# player won't reset the game trying to get other cards. The variable
# MIN_BOOSTER_STOCK defines how many cards are stocked in save. If the number
# in this variable is 5, by example, and the values are initialized. Even if
# the player saves and keep opening the packs and resetting, he gets the same
# first 5 cards, since these cards are randomized only the 5 cards ahead. To
# disable this feature, just make the variable value as 0.
#
# I suggest you to initialize this list after the professor lecture, for all 
# packs. If, in your game, the last pack index that you use is 2, after
# professor lecture add the script commands:
#
# $PokemonGlobal.fillBoosterStock(0)
# $PokemonGlobal.fillBoosterStock(1)
# $PokemonGlobal.fillBoosterStock(2)
#
#===============================================================================

MIN_BOOSTER_STOCK=5

BOOSTER_LIST=[
  nil,
  # The below line is the booster of index 1
  #Charmander Deck
  [4,5,37,58,77,126,155,156,218,228,255,256,324,322],
  #Bulbasaur Deck
  [1,2,43,46,69,102,114,152,153,187,191,252,253,273],
  #Squirtle Deck
  [7,8,54,60,72,79,116,120,129,147,158,159,258,259],
  #Rocket Deck
  [109, 110, 23, 24, 71, 202, 129, 52, 53, 108, 57, 237, 262, 91, 213, 96, 20, 228,302,73,210,95,111,115,33,31,112,150,391],
  #Egg Deck
  [172,173,174,175,236,238,239,240,298,360,102,113,115,273,191,396],
  #Champion Deck
  [144, 145, 146, 149,248,249,250,373,377,378,379],
  #Pikachu Deck
  [25,26,179,125,81,82,172,239,311,312,132],
  #Eevee Deck
  [132,133,134,135,136,196,197]
]


if MIN_BOOSTER_STOCK>0
  class PokemonGlobalMetadata
    def fillBoosterStock(boosterIndex)
      @boosterStock=[]  if !@boosterStock
      @boosterStock[boosterIndex]=[] if @boosterStock.size<=boosterIndex
      while @boosterStock[boosterIndex].size<MIN_BOOSTER_STOCK
        randomCard = getRandomTriadCard(boosterIndex)
        @boosterStock[boosterIndex].push(randomCard)
      end
    end
    
    def getFirstBoosterAtStock(boosterIndex)
      # Called twice since the variable maybe isn't initialized
      fillBoosterStock(boosterIndex)
      newCard = @boosterStock[boosterIndex].shift
      fillBoosterStock(boosterIndex)
      return newCard
    end
  end
end  

def getRandomTriadCard(boosterIndex)
  overflowCount=0
  loop do
    overflowCount+=1
    raise "Can't draw a random card!" if overflowCount>10000
    randomPokemon = rand(PBSpecies.maxValue)+1
    cname=getConstantName(PBSpecies,randomPokemon) rescue nil
    next if !cname
    if (!BOOSTER_LIST[boosterIndex] || BOOSTER_LIST[boosterIndex].empty? || 
        BOOSTER_LIST[boosterIndex].include?(randomPokemon))
      return randomPokemon 
    end
  end 
end  

def giveBoosterPack(item,numberOfCards,boosterIndex=0)
  Kernel.pbMessage(_INTL("{1} opened the {2}.",
      $Trainer.name,PBItems.getName(item)))
  cardEarned = 0
  overflowCount = 0
  for i in 0...numberOfCards
    card=-1
    if MIN_BOOSTER_STOCK>0
      card = $PokemonGlobal.getFirstBoosterAtStock(boosterIndex)
    else
      card = getRandomTriadCard(boosterIndex)
    end
    pbGiveTriadCard(card,1)
    Kernel.pbMessage(_INTL("{1} draws {2} card!",
        $Trainer.name,getConstantName(PBSpecies,card)))
  end
  return 3
end

def getSpeciesOfType(type)
  ret = []
  dexdata=pbOpenDexData
  for species in 1..PBSpecies.maxValue
    # Type
    pbDexDataOffset(dexdata,species,8)
    type1=dexdata.fgetb
    type2=dexdata.fgetb
    ret.push(species) if type==type1 || type==type2
  end
  return ret
end  

ItemHandlers::UseFromBag.add(:CHARMANDERPACK,proc{|item|
  giveBoosterPack(item,3,1)
})

ItemHandlers::UseFromBag.add(:BULBASAURPACK,proc{|item|
  giveBoosterPack(item,3,2)
})

ItemHandlers::UseFromBag.add(:SQUIRTLEPACK,proc{|item|
  giveBoosterPack(item,3,3)
})

ItemHandlers::UseFromBag.add(:ROCKETPACK,proc{|item|
  giveBoosterPack(item,3,4)
})

ItemHandlers::UseFromBag.add(:EGGPACK,proc{|item|
  giveBoosterPack(item,3,5)
})

ItemHandlers::UseFromBag.add(:CHAMPIONPACK,proc{|item|
  giveBoosterPack(item,3,6)
})

ItemHandlers::UseFromBag.add(:PIKACHUPACK,proc{|item|
  giveBoosterPack(item,3,7)
})

ItemHandlers::UseFromBag.add(:EEVEEPACK,proc{|item|
  giveBoosterPack(item,3,8)
})