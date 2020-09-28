#---------------------------------------------
#Code by: TastyRedTomato
#---------------------------------------------
#Call as pbDexSeenPokemon(species,gender,form)
#species: for example :BULBASAUR
#gender: either 0 (male) or 1 (female)
#form: the form id, standard form is 0
#---------------------------------------------

def pbDexSeenPokemon(species,gender,form)
  $Trainer.setSeen(species) #sets the pokemon as seen in the pokedex
  pkmn = pbGenPkmn(species,10) #creates a lvl10 version of the pokémon
  pkmn.form = form #sets the pokemon form
  pkmn.setGender(gender) #sets the pokemon gender
  pbSeenForm(pkmn) #adds the specified version of the pokemon to the dex
  return
end