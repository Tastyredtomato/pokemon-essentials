################################################################################
#  Roaming Tracker by TastyRedTomato
#---------------------------------------
# These commands track the current map of the roaming pokemon 
# (pbcheckRoaming(index)) returns a string with the map name
# (pbcheckRoamingMapno(index)) returns the map id as an integer
#
# index is the number of the roaming pokemon as is defined in Settings
# The first pokémon is 0, the second one is 1, and so on... 
# Using a value that doesn't exist will result in an error
#
# The script returns a string containing the map the pokémon is currently on
# Note that even if a Pokémon is not roaming, the script will still return a value
# That's why it's important to still use your roaming switches or 
# check for captured/dead mons
#
# the value "map not set" or zero respectively will be returned if  
# the developer has cleared the data using the debug mode
#
################################################################################

def pbcheckRoaming(index) #this command returns the map name
    pkmn = RoamingSpecies[index]
    name = PBSpecies.getName(getID(PBSpecies,pkmn[0]))+" (Lv. #{pkmn[1]})"
    curmap = $PokemonGlobal.roamPosition[index]
    roamstatus = ""
   if curmap
      mapinfos = ($RPGVX) ? load_data("Data/MapInfos.rvdata") : load_data("Data/MapInfos.rxdata")
      roamstatus = "[#{mapinfos[curmap].name}]"
   else
      roamstatus = "[map not set]"
   end
    
return roamstatus

end


def pbcheckRoamingMapno(index) #this command returns the map id
    pkmn = RoamingSpecies[index]
    name = PBSpecies.getName(getID(PBSpecies,pkmn[0]))+" (Lv. #{pkmn[1]})"
    curmap = $PokemonGlobal.roamPosition[index]
    roamstatus = 0
   if curmap
      mapinfos = ($RPGVX) ? load_data("Data/MapInfos.rvdata") : load_data("Data/MapInfos.rxdata")
      roamstatus = "#{curmap}".to_i
   else
      roamstatus = 0
   end
    
return roamstatus
end