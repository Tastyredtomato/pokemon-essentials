#===============================================================================
#HMs as Items by FL
#
#additional editing by derFischae and Bulbasaurlvl5
#===============================================================================
#
#This script is for Pokémon Essentials 17.
#
#features included: 
#          - allows surfing, cutting trees etc. by using items
#            instead of pokemon moves
#          - HM moves can still be used
#          - supports the script "Following Pokemon" 
#            https://www.pokecommunity.com/showthread.php?t=360846
#
#Installation: Installation as simple as it can be.
# 1) Open items.txt in your PBS folder and add the following items
#    (change the numbers 1-12 such that it does not coincide with
#    one of your allready existing items):
#      1,CUTITEM,Shears,Shears,8,0,"A shears to cut small trees.",2,0,6,
#      2,DIGITEM,Shovel,Shovels,8,0,"A shovel to escape from caves.",2,0,6,
#      3,DIVEITEM,Diving Goggles,Diving Goggles,8,0,"Diving Goggles to dive at deep seas.",2,0,6,
#      4,FLAMUKEM,Flash Light,Flash Lights,8,0,"A flash light to light up dark caves.",2,0,6,
#      5,FLYITEM,Wings,Wings,8,0,"Wings to fly like Icarus. Didn't expect this greek culture reference, did ya.",2,0,6,
#      6,HEADBUTTITEM,Thick Branch,Thick Branches,8,0,"A Thick Branch to shake pokemon of trees.",2,0,6,
#      7,ROCKSMAMUKEM,Pickaxe,Pickaxes,8,0,"A pickaxe to smash small rocks.",2,0,6,
#      8,STRENGTHITEM,Working Gloves,Working Gloves,8,0,"Working gloves to move boulders.",2,0,6,
#      9,SURFITEM,Surfboard,Surfboards,8,0,"A surfboard to move on water.",2,0,6,
#      10,SWEETSCENTITEM,Sweet Scent,Sweet Scent,8,0,"Sweet scent to attract pokemon.",2,0,6,
#      11,TELEPORTITEM,Teleporter,Teleporters,8,0,"A teleporter to return to the last pokemon center.",2,0,6,
#      12,WATERFALLITEM,Waterfall Equipment,Waterfall Equipments,8,0,"Waterfall equipment to climb waterfalls.",2,0,6,
# 2) add pictures in the folder \Graphics\Icons with the names item001.png, ... item.013.png, 
#    where the number in the names equal the number above 
# 3) Insert a new file in the script editor above main,
#    name it HMs_as_items and copy this code into it.
#    If you use the script "Following Pokemon" 
#    https://www.pokecommunity.com/showthread.php?t=360846
#    make sure that you insert HMs_as_items UNDER that script.
# 4) If you use the script "Following Pokemon" set 
#           IUSEFOLLOWINGPOKEMON = true
#    in the settings section below.

################################################################################
# There is a bug in pokemon essentials occuring while using an item in the ready
# menu or in the bag. It happens that the flag $game_temp.in_menu is not set 
# to false. Hence all events including there animations are frozen. This is
# especially annoying if you want to replace rocksmash with an item,
# but you won't get the smash animation.
#
# Well just for replacing HMs with Items you can simply add
#      $game_temp.in_menu = false
# at the beginning of the methods useMoveCut, useMoveRockSmash, ...
# instead of using this bug fix. But infact this bug fix is also useful for
# fishing, etc.
# So it is recommend to use "Bug fixes for Item Usage in Field" see
#      https://www.pokecommunity.com/showthread.php?t=429033
################################################################################

#===============================================================================
# SETTINGS
#===============================================================================
IUSEFOLLOWINGPOKEMON = true
#false - means that you don't use the script "Following Pokemon"
#true  - means that you use the script "Following Pokemon" and that you have 
#        inserted the Following Pokemon Script above this script

#===============================================================================
# Cut
#===============================================================================
#===============================================================================
# overrides the method Kernel.pbRockSmash in pField_FieldMoves
# to include interacting via CUTITEM with a tree on the map
#===============================================================================
def Kernel.pbCut
  move = getID(PBMoves,:CUT)
  movefinder = Kernel.pbCheckMove(move)
  if !pbCheckHiddenMoveBadge(BADGEFORCUT,false) || (!$DEBUG && !movefinder && $PokemonBag.pbQuantity(PBItems::CUTITEM)==0)
    Kernel.pbMessage(_INTL("It's a small tree. Come back then you or your Pokémon have learned to cut it."))
    return false
  end
  if Kernel.pbConfirmMessage(_INTL("Would you like to cut this small tree?"))
    if $PokemonBag.pbQuantity(PBItems::CUTITEM)>0
      Kernel.pbMessage(_INTL("{1} used {2}!",$Trainer.name,PBItems.getName(PBItems::CUTITEM)))
      pbHiddenMoveAnimation(nil)
    else
      speciesname = (movefinder) ? movefinder.name : $Trainer.name
      Kernel.pbMessage(_INTL("{1} used {2}!",speciesname,PBMoves.getName(move)))
      pbHiddenMoveAnimation(movefinder)
    end
    return true
  end
  return false
end

#===============================================================================
# adding new methods in Script PItem_Items
# to include interacting via CUTITEM with a tree on the map
#===============================================================================
def canUseMoveCut?
  showmsg = true
   return false if !pbCheckHiddenMoveBadge(BADGEFORCUT,showmsg)
   facingEvent = $game_player.pbFacingEvent
   if !facingEvent || facingEvent.name!="Tree"
     Kernel.pbMessage(_INTL("Can't use that here.")) if showmsg
     return false
   end
   return true
end

def useMoveCut
   if !pbHiddenMoveAnimation(nil)
     Kernel.pbMessage(_INTL("{1} used {2}!",$Trainer.name,PBItems.getName(PBItems::CUTITEM)))
   end
   facingEvent = $game_player.pbFacingEvent
   if facingEvent
     pbSmashEvent(facingEvent)
   end
   return true
end

#===============================================================================
# adding new ItemHandlers in the script PItem_ItemEffects
# for the Items to use them in the bag and in field
#===============================================================================
ItemHandlers::UseFromBag.add(:CUTITEM,proc{|item|
   next canUseMoveCut? ? 2 : 0
})

ItemHandlers::UseInField.add(:CUTITEM,proc{|item|
   useMoveCut if canUseMoveCut?
})

#===============================================================================
# Dig
#===============================================================================
#===============================================================================
# adding new methods in Script PItem_Items
# to include interacting via CUTITEM with a tree in the bag
#===============================================================================
def canUseMoveDig?
  showmsg = true
  escape = ($PokemonGlobal.escapePoint rescue nil)
  if !escape || escape==[]
    Kernel.pbMessage(_INTL("Can't use that here.")) if showmsg
    return false
  end
  if $game_player.pbHasDependentEvents? && (IUSEFOLLOWINGPOKEMON ? !$game_switches[Following_Activated_Switch] : true)
    Kernel.pbMessage(_INTL("It can't be used when you have someone with you.")) if showmsg
    return false
  end
  return true
end

def confirmUseMoveDig
  escape = ($PokemonGlobal.escapePoint rescue nil)
  return false if !escape || escape==[]
  mapname = pbGetMapNameFromId(escape[0])
  return Kernel.pbConfirmMessage(_INTL("Want to escape from here and return to {1}?",mapname))
end

def useMoveDig
  escape = ($PokemonGlobal.escapePoint rescue nil)
  if escape
    if !pbHiddenMoveAnimation(nil)
      Kernel.pbMessage(_INTL("{1} used a {2}!",$Trainer.name,PBItems.getName(PBItems::DIGITEM)))
    end
    pbFadeOutIn(99999){
       $game_temp.player_new_map_id    = escape[0]
       $game_temp.player_new_x         = escape[1]
       $game_temp.player_new_y         = escape[2]
       $game_temp.player_new_direction = escape[3]
       Kernel.pbCancelVehicles
       $scene.transfer_player
       $game_map.autoplay
       $game_map.refresh
    }
    pbEraseEscapePoint
    return true
  end
  return false
end

#===============================================================================
# adding new ItemHandlers in the script PItem_ItemEffects
# for the Items to use them in the bag and in field
#===============================================================================
ItemHandlers::UseFromBag.add(:DIGITEM,proc{|item|
   next canUseMoveDig? ? 2 : 0
})

ItemHandlers::UseInField.add(:DIGITEM,proc{|item|
   useMoveDig if confirmUseMoveDig
})

#===============================================================================
# Dive
#===============================================================================
#===============================================================================
# overrides the methods Kernel.pbDive and Kernel.pbSurfacing in pField_FieldMoves
# to include interacting via DivingGoggles with a deap sea on the map
#===============================================================================

def Kernel.pbDive
  divemap = pbGetMetadata($game_map.map_id,MetadataDiveMap)
  return false if !divemap
  move = getID(PBMoves,:DIVE)
  movefinder = Kernel.pbCheckMove(move)
  if !pbCheckHiddenMoveBadge(BADGEFORDIVE,false) || (!$DEBUG && !movefinder && $PokemonBag.pbQuantity(PBItems::DIVEITEM)==0)
    Kernel.pbMessage(_INTL("The sea is deep here. Come back then you or your Pokémon learned to go underwater."))
    return false
  end
  if Kernel.pbConfirmMessage(_INTL("The sea is deep here. Would you like to use Dive?"))
    if $PokemonBag.pbQuantity(PBItems::DIVEITEM)>0
      Kernel.pbMessage(_INTL("{1} used {2}!",$Trainer.name,PBItems.getName(PBItems::DIVEITEM)))
      pbHiddenMoveAnimation(nil)
    else
      speciesname = (movefinder) ? movefinder.name : $Trainer.name
      Kernel.pbMessage(_INTL("{1} used {2}!",speciesname,PBMoves.getName(move)))
      pbHiddenMoveAnimation(movefinder)
    end
    pbFadeOutIn(99999){
       $game_temp.player_new_map_id    = divemap
       $game_temp.player_new_x         = $game_player.x
       $game_temp.player_new_y         = $game_player.y
       $game_temp.player_new_direction = $game_player.direction
       Kernel.pbCancelVehicles
       $PokemonGlobal.diving = true
       Kernel.pbUpdateVehicle
       $scene.transfer_player(false)
       $game_map.autoplay
       $game_map.refresh
    }
    return true
  end
  return false
end

def Kernel.pbSurfacing
  return if !$PokemonGlobal.diving
  divemap = nil
  meta = pbLoadMetadata
  for i in 0...meta.length
    if meta[i] && meta[i][MetadataDiveMap] && meta[i][MetadataDiveMap]==$game_map.map_id
      divemap = i; break
    end
  end
  return if !divemap
  move = getID(PBMoves,:DIVE)
  movefinder = Kernel.pbCheckMove(move)
  if !pbCheckHiddenMoveBadge(BADGEFORDIVE,false) || (!$DEBUG && !movefinder && $PokemonBag.pbQuantity(PBItems::DIVEITEM)==0)
    Kernel.pbMessage(_INTL("Light is filtering down from above.  Come back then you or your Pokémon learned to go underwater."))
    return false
  end
  if Kernel.pbConfirmMessage(_INTL("Light is filtering down from above. Would you like to use Dive?"))
    if $PokemonBag.pbQuantity(PBItems::DIVEITEM)>0
      Kernel.pbMessage(_INTL("{1} used {2}!",$Trainer.name,PBItems.getName(PBItems::DIVEITEM)))
      pbHiddenMoveAnimation(nil)
    else
      speciesname = (movefinder) ? movefinder.name : $Trainer.name
      Kernel.pbMessage(_INTL("{1} used {2}!",speciesname,PBMoves.getName(move)))
      pbHiddenMoveAnimation(movefinder)
    end
    pbFadeOutIn(99999){
       $game_temp.player_new_map_id    = divemap
       $game_temp.player_new_x         = $game_player.x
       $game_temp.player_new_y         = $game_player.y
       $game_temp.player_new_direction = $game_player.direction
       Kernel.pbCancelVehicles
       $PokemonGlobal.surfing = true
       Kernel.pbUpdateVehicle
       $scene.transfer_player(false)
       surfbgm = pbGetMetadata(0,MetadataSurfBGM)
       (surfbgm) ?  pbBGMPlay(surfbgm) : $game_map.autoplayAsCue
       $game_map.refresh
    }
    return true
  end
  return false
end

#===============================================================================
# adding new methods in Script PItem_Items
# to include interacting via DIVEITEM with deep sea in the bag
#===============================================================================
def canUseMoveDive?
   showmsg = true
   return false if !pbCheckHiddenMoveBadge(BADGEFORDIVE,showmsg)
   if $PokemonGlobal.diving
     return true if DIVINGSURFACEANYWHERE
     divemap = nil
     meta = pbLoadMetadata
     for i in 0...meta.length
       if meta[i] && meta[i][MetadataDiveMap] && meta[i][MetadataDiveMap]==$game_map.map_id
         divemap = i; break
       end
     end
     if !PBTerrain.isDeepWater?($MapFactory.getTerrainTag(divemap,$game_player.x,$game_player.y))
       Kernel.pbMessage(_INTL("Can't use that here.")) if showmsg
       return false
     end
   else
     if !pbGetMetadata($game_map.map_id,MetadataDiveMap)
       Kernel.pbMessage(_INTL("Can't use that here.")) if showmsg
       return false
     end
     if !PBTerrain.isDeepWater?($game_player.terrain_tag)
       Kernel.pbMessage(_INTL("Can't use that here.")) if showmsg
       return false
     end
   end
   return true
end

def useMoveDive
   wasdiving = $PokemonGlobal.diving
   if $PokemonGlobal.diving
     divemap = nil
     meta = pbLoadMetadata
     for i in 0...meta.length
       if meta[i] && meta[i][MetadataDiveMap] && meta[i][MetadataDiveMap]==$game_map.map_id
         divemap = i; break
       end
     end
   else
     divemap = pbGetMetadata($game_map.map_id,MetadataDiveMap)
   end
   return false if !divemap
   if !pbHiddenMoveAnimation(nil)
     Kernel.pbMessage(_INTL("{1} used {2}!",$Trainer.name,PBItems.getName(PBItems::DIVEITEM)))
   end
   pbFadeOutIn(99999){
      $game_temp.player_new_map_id    = divemap
      $game_temp.player_new_x         = $game_player.x
      $game_temp.player_new_y         = $game_player.y
      $game_temp.player_new_direction = $game_player.direction
      Kernel.pbCancelVehicles
      (wasdiving) ? $PokemonGlobal.surfing = true : $PokemonGlobal.diving = true
      Kernel.pbUpdateVehicle
      $scene.transfer_player(false)
      $game_map.autoplay
      $game_map.refresh
   }
   return true
end

#===============================================================================
# adding new ItemHandlers in the script PItem_ItemEffects
# for the Items to use them in the bag and in field
#===============================================================================
ItemHandlers::UseFromBag.add(:DIVEITEM,proc{|item|
   next canUseMoveDive? ? 2 : 0
})

ItemHandlers::UseInField.add(:DIVEITEM,proc{|item|
   useMoveDive if canUseMoveDive?
})

#===============================================================================
# Flash
#===============================================================================
#===============================================================================
# adding new methods in Script PItem_Items
# to include interacting via FLAMUKEM with deep sea in the bag
#===============================================================================
def canUseMoveFlash?
   showmsg = true
   return false if !pbCheckHiddenMoveBadge(BADGEFORFLASH,showmsg)
   if !pbGetMetadata($game_map.map_id,MetadataDarkMap)
     Kernel.pbMessage(_INTL("Can't use that here.")) if showmsg
     return false
   end
   if $PokemonGlobal.flashUsed
     Kernel.pbMessage(_INTL("Flash is already being used.")) if showmsg
     return false
   end
   return true
end

def useMoveFlash
   darkness = $PokemonTemp.darknessSprite
   return false if !darkness || darkness.disposed?
   if !pbHiddenMoveAnimation(nil)
     Kernel.pbMessage(_INTL("{1} used a {2}!",$Trainer.name,PBItems.getName(PBItems::FLAMUKEM)))
   end
   $PokemonGlobal.flashUsed = true
   while darkness.radius<176
     Graphics.update
     Input.update
     pbUpdateSceneMap
     darkness.radius += 4
   end
   return true
end

#===============================================================================
# adding new ItemHandlers in the script PItem_ItemEffects
# for the Items to use them in the bag and in field
#===============================================================================
ItemHandlers::UseFromBag.add(:FLAMUKEM,proc{|item|
   next canUseMoveFlash? ? 2 : 0
})

ItemHandlers::UseInField.add(:FLAMUKEM,proc{|item|
   useMoveFlash if canUseMoveFlash?
})

#===============================================================================
# Fly
#===============================================================================
#===============================================================================
# adding new methods in Script PItem_Items
# to include interacting via FLAMUKEM with deep sea in the bag
#===============================================================================
def canUseMoveFly?
  showmsg = true
  return false if !pbCheckHiddenMoveBadge(BADGEFORFLY,showmsg)
   if $game_player.pbHasDependentEvents? && (IUSEFOLLOWINGPOKEMON ? !$game_switches[Following_Activated_Switch] : true)
     Kernel.pbMessage(_INTL("It can't be used when you have someone with you.")) if showmsg
     return false
   end
   if !pbGetMetadata($game_map.map_id,MetadataOutdoor)
     Kernel.pbMessage(_INTL("Can't use that here.")) if showmsg
     return false
   end
   return true
end  

def useMoveFly
  scene=PokemonRegionMap_Scene.new(-1,false)
  screen=PokemonRegionMapScreen.new(scene)
  $PokemonTemp.flydata=screen.pbStartFlyScreen
  if !$PokemonTemp.flydata || $game_switches[87]==true
    Kernel.pbMessage(_INTL("You didn't lift off."))
    return
  end
  if !pbHiddenMoveAnimation(nil)
    Kernel.pbMessage(_INTL("{1} used {2}!",$Trainer.name,PBItems.getName(PBItems::FLYITEM)))
  end
  pbFadeOutIn(99999){
    Kernel.pbCancelVehicles
    $game_temp.player_new_map_id=$PokemonTemp.flydata[0]
    $game_temp.player_new_x=$PokemonTemp.flydata[1]
    $game_temp.player_new_y=$PokemonTemp.flydata[2]
    $PokemonTemp.flydata=nil
    $game_temp.player_new_direction=2
    $scene.transfer_player
    $game_map.autoplay
    $game_map.refresh
  }
  pbEraseEscapePoint
  return true
end

#===============================================================================
# adding new ItemHandlers in the script PItem_ItemEffects
# for the Items to use them in the bag and in field
#===============================================================================
ItemHandlers::UseFromBag.add(:FLYITEM,proc{|item|
   next canUseMoveFly? ? 2 : 0
})

ItemHandlers::UseInField.add(:FLYITEM,proc{|item|
   useMoveFly if canUseMoveFly?
})

#===============================================================================
# Headbutt
#===============================================================================
# overrides the method Kernel.pbHeadbutt in pField_FieldMoves
# to include interacting via HEADBUTTITEM with a shakable tree on the map
#===============================================================================
def Kernel.pbHeadbutt(event)
  move = getID(PBMoves,:HEADBUTT)
  movefinder = Kernel.pbCheckMove(move)
  if !$DEBUG && !movefinder && $PokemonBag.pbQuantity(PBItems::HEADBUTTITEM)==0
    Kernel.pbMessage(_INTL("A Pokémon could be in this tree. Come back then you or your Pokémon learned to shake it."))
    return false
  end
  if Kernel.pbConfirmMessage(_INTL("A Pokémon could be in this tree. Would you like to use Headbutt?"))
    if $PokemonBag.pbQuantity(PBItems::HEADBUTTITEM)>0
      Kernel.pbMessage(_INTL("{1} slaps the tree with a {2}!",$Trainer.name,PBItems.getName(PBItems::HEADBUTTITEM)))
      pbHiddenMoveAnimation(nil)
    else
      speciesname = (movefinder) ? movefinder.name : $Trainer.name
      Kernel.pbMessage(_INTL("{1} used {2}!",speciesname,PBMoves.getName(move)))
      pbHiddenMoveAnimation(movefinder)
    end
    Kernel.pbHeadbuttEffect(event)
    return true
  end
  return false
end

#===============================================================================
# adding new methods in Script PItem_Items
# to include interacting via HEADBUTTITEM with shakable trees from the bag
#===============================================================================
def canUseMoveHeadbutt?
   showmsg = true
   facingEvent = $game_player.pbFacingEvent
   if !facingEvent || facingEvent.name!="HeadbuttTree"
     Kernel.pbMessage(_INTL("Can't use that here.")) if showmsg
     return false
   end
   return true
end

def useMoveHeadbutt
   if !pbHiddenMoveAnimation(nil)
     Kernel.pbMessage(_INTL("{1} slaps the tree with {2}!",$Trainer.name,PBItems.getName(PBItems::HEADBUTTITEM)))
   end
   facingEvent = $game_player.pbFacingEvent
   Kernel.pbHeadbuttEffect(facingEvent)
end

#===============================================================================
# adding new ItemHandlers in the script PItem_ItemEffects
# for the Items to use them in the bag and in field
#===============================================================================
ItemHandlers::UseFromBag.add(:HEADBUTTITEM,proc{|item|
   next canUseMoveHeadbutt? ? 2 : 0
})

ItemHandlers::UseInField.add(:HEADBUTTITEM,proc{|item|
   useMoveHeadbutt if canUseMoveHeadbutt?
})

#===============================================================================
# Rock Smash
#===============================================================================
#===============================================================================
# overrides the method Kernel.pbRockSmash in Script PField_FieldMoves
# to include interacting via a ROCKSMAMUKEM with a rock on the map
#===============================================================================
def Kernel.pbRockSmash
  move = getID(PBMoves,:ROCKSMASH)
  movefinder = Kernel.pbCheckMove(move)
  if !pbCheckHiddenMoveBadge(BADGEFORROCKSMASH,false) || (!$DEBUG && !movefinder && $PokemonBag.pbQuantity(PBItems::ROCKSMAMUKEM)==0)
    Kernel.pbMessage(_INTL("It's a rugged rock. Come back then you or your Pokémon have learned to smash it."))
    return false
  end
  if Kernel.pbConfirmMessage(_INTL("This rock appears to be breakable. Would you like to use Rock Smash?"))
    if $PokemonBag.pbQuantity(PBItems::ROCKSMAMUKEM)>0
      Kernel.pbMessage(_INTL("{1} used {2}!",$Trainer.name,PBItems.getName(PBItems::ROCKSMAMUKEM)))
      pbHiddenMoveAnimation(nil)
    else
      speciesname = (movefinder) ? movefinder.name : $Trainer.name
      Kernel.pbMessage(_INTL("{1} used {2}!",speciesname,PBMoves.getName(move)))
      pbHiddenMoveAnimation(movefinder)
    end
    return true
  end
  return false
end

#===============================================================================
# adding new method Kernel.pbRockSmash in Script PItem_Items
# to include interacting via a ROCKSMAMUKEM with a rock on the map
#===============================================================================
def canUseMoveRockSmash?
  showmsg = true
  return false if !pbCheckHiddenMoveBadge(BADGEFORROCKSMASH,showmsg)
  facingEvent = $game_player.pbFacingEvent
  if !facingEvent || facingEvent.name!="Rock"
    Kernel.pbMessage(_INTL("Can't use that here.")) if showmsg
    return false
  end
  return true
end

def useMoveRockSmash
  if !pbHiddenMoveAnimation(nil)
    Kernel.pbMessage(_INTL("{1} used {2}!",$Trainer.name,PBItems.getName(PBItems::ROCKSMAMUKEM)))
  end
  facingEvent = $game_player.pbFacingEvent
  if facingEvent
    pbSmashEvent(facingEvent)
    pbRockSmashRandomEncounter
  end
  return true
end

#===============================================================================
# adding new ItemHandlers in the script PItem_ItemEffects
# for the Items to use them in the bag and in field
#===============================================================================
ItemHandlers::UseFromBag.add(:ROCKSMAMUKEM,proc{|item|
   next canUseMoveRockSmash? ? 2 : 0
})

ItemHandlers::UseInField.add(:ROCKSMAMUKEM,proc{|item|
   useMoveRockSmash if canUseMoveRockSmash?
})

#===============================================================================
# Strength
#===============================================================================
#===============================================================================
# overrides the method Kernel.pbRockSmash in Script PField_FieldMoves
# to include interacting via STRENGTHITEM (exoskeleton :) ) with a rock on the map
#===============================================================================
def Kernel.pbStrength
  if $PokemonMap.strengthUsed
    Kernel.pbMessage(_INTL("You made it possible to move boulders around."))
    return false
  end
  move = getID(PBMoves,:STRENGTH)
  movefinder = Kernel.pbCheckMove(move)
    if !pbCheckHiddenMoveBadge(BADGEFORSTRENGTH,false) ||
      (!$DEBUG && !movefinder && $PokemonBag.pbQuantity(PBItems::STRENGTHITEM)==0)
    Kernel.pbMessage(_INTL("It's a big boulder, but theoretically it should be movable."))
    return false
  end
  if Kernel.pbConfirmMessage(_INTL("Would you like to move the boulder?"))
    if $PokemonBag.pbQuantity(PBItems::STRENGTHITEM)>0
      Kernel.pbMessage(_INTL("{1} used {2}!",$Trainer.name,PBItems.getName(PBItems::STRENGTHITEM)))
      pbHiddenMoveAnimation(nil)
    else
      speciesname = (movefinder) ? movefinder.name : $Trainer.name
      Kernel.pbMessage(_INTL("{1} used {2}!",speciesname,PBMoves.getName(move)))
      pbHiddenMoveAnimation(movefinder)
      Kernel.pbMessage(_INTL("{1}'s Strength made it possible to move boulders around!",speciesname))
    end
    $PokemonMap.strengthUsed = true
    return true
  end
  return false
end

#===============================================================================
# adding new methods in Script PItem_Items
# to include interacting via STRENGTHITEM with a rock on the map from the bag
#===============================================================================
def canUseMoveStrength?
   showmsg = true
   return false if !pbCheckHiddenMoveBadge(BADGEFORSTRENGTH,showmsg)
   if $PokemonMap.strengthUsed
     Kernel.pbMessage(_INTL("{1} already being equipped.",PBItems.getName(PBItems::STRENGTHITEM))) if showmsg
     return false
   end
   return true
end

def useMoveStrength
   if !pbHiddenMoveAnimation(nil)
     Kernel.pbMessage(_INTL("{1} used the {2} to move boulders!",$Trainer.name,PBItems.getName(PBItems::STRENGTHITEM)))
   end
   $PokemonMap.strengthUsed = true
   return true
end

#===============================================================================
# adding new ItemHandlers in the script PItem_ItemEffects
# for the Items to use them in the bag and in field
#===============================================================================
ItemHandlers::UseFromBag.add(:STRENGTHITEM,proc{|item|
   next canUseMoveStrength? ? 2 : 0
})

ItemHandlers::UseInField.add(:STRENGTHITEM,proc{|item|
   useMoveStrength if canUseMoveStrength?
})

#===============================================================================
# Surf
#===============================================================================
#===============================================================================
# overrides the method Kernel.pbSurf in Script PField_FieldMoves
# to include interacting via SURFITEM with water on the map
#===============================================================================
def Kernel.pbSurf
  return false if $game_player.pbHasDependentEvents? && (IUSEFOLLOWINGPOKEMON ? !$game_switches[Following_Activated_Switch] : true)
  #return false if $game_player.pbHasDependentEvents? && !$game_switches[Following_Activated_Switch]
  move = getID(PBMoves,:SURF)
  movefinder = Kernel.pbCheckMove(move)
  if !pbCheckHiddenMoveBadge(BADGEFORSURF,false) || (!$DEBUG && !movefinder && $PokemonBag.pbQuantity(PBItems::SURFITEM)==0)
    return false
  end
  if Kernel.pbConfirmMessage(_INTL("The water is a deep blue...\nWould you like to surf on it?"))
    if $PokemonBag.pbQuantity(PBItems::SURFITEM)>0
      Kernel.pbMessage(_INTL("{1} starts surfing!",$Trainer.name))
      Kernel.pbCancelVehicles
      pbHiddenMoveAnimation(nil)
    else
      speciesname = (movefinder) ? movefinder.name : $Trainer.name
      Kernel.pbMessage(_INTL("{1} used {2}!",speciesname,PBMoves.getName(move)))
      Kernel.pbCancelVehicles
      pbHiddenMoveAnimation(movefinder)
    end
    surfbgm = pbGetMetadata(0,MetadataSurfBGM)
    $PokemonTemp.dependentEvents.check_surf(true) if IUSEFOLLOWINGPOKEMON == true
    pbCueBGM(surfbgm,0.5) if surfbgm
    pbStartSurfing
    return true
  end
  return false
end

#===============================================================================
# adding new methods in Script PItem_Items
# to include interacting via SURFITEM with water on the map from the bag
#===============================================================================
def canUseMoveSurf?
   showmsg = true
   return false if !pbCheckHiddenMoveBadge(BADGEFORSURF,showmsg)
   if $PokemonGlobal.surfing
     Kernel.pbMessage(_INTL("You're already surfing.")) if showmsg
     return false
   end
   if $game_player.pbHasDependentEvents? && (IUSEFOLLOWINGPOKEMON ? !$game_switches[Following_Activated_Switch] : true)
     Kernel.pbMessage(_INTL("It can't be used when you have someone with you.")) if showmsg
     return false
   end
   if pbGetMetadata($game_map.map_id,MetadataBicycleAlways)
     Kernel.pbMessage(_INTL("Let's enjoy cycling!")) if showmsg
     return false
   end
   if !PBTerrain.isSurfable?(Kernel.pbFacingTerrainTag) ||
      !$game_map.passable?($game_player.x,$game_player.y,$game_player.direction,$game_player)
     Kernel.pbMessage(_INTL("No surfing here!")) if showmsg
     return false
   end
   ########################
   #das folgende hatte FL im code statt der letzten if abfrage oben 
   #-----------------------
   #terrain=Kernel.pbFacingTerrainTag
   #notCliff=$game_map.passable?($game_player.x,$game_player.y,$game_player.direction)
   #if !PBTerrain.isSurfable?(terrain) || !notCliff
   #  Kernel.pbMessage(_INTL("No surfing here!"))
   #  return false
   #end
   #######################
   return true
end

def useMoveSurf
   $game_temp.in_menu = false
   Kernel.pbCancelVehicles
   if !pbHiddenMoveAnimation(nil)
     Kernel.pbMessage(_INTL("{1} used {2}!",$Trainer.name,PBItems.getName(PBItems::SURFITEM)))
   end
   surfbgm = pbGetMetadata(0,MetadataSurfBGM)
   pbCueBGM(surfbgm,0.5) if surfbgm
   pbStartSurfing
   return true
end 

#===============================================================================
# adding new ItemHandlers in the script PItem_ItemEffects
# for the Items to use them in the bag and in field
#===============================================================================
ItemHandlers::UseFromBag.add(:SURFITEM,proc{|item|
   next canUseMoveSurf? ? 2 : 0
})

ItemHandlers::UseInField.add(:SURFITEM,proc{|item|
   useMoveSurf if canUseMoveSurf?
})

#===============================================================================
# Sweet Scent
#===============================================================================
#===============================================================================
# adding new methods in Script PItem_Items
# to include interacting via SWEETSCENTITEM from the bag
#===============================================================================
def canUseMoveSweetscent?
   return true
end

def useMoveSweetscent
   if !pbHiddenMoveAnimation(nil)
     Kernel.pbMessage(_INTL("{1} used {2}!",$Trainer.name,PBItems.getName(PBItems::SWEETSCENTITEM)))
   end
   pbSweetScent
   return true
end

#===============================================================================
# adding new ItemHandlers in the script PItem_ItemEffects
# for the Items to use them in the bag and in field
#===============================================================================
ItemHandlers::UseFromBag.add(:SWEETSCENTITEM,proc{|item|
   next canUseMoveSweetscent? ? 2 : 0
})

ItemHandlers::UseInField.add(:SWEETSCENTITEM,proc{|item|
   useMoveSweetscent if canUseMoveSweetscent?
})

#===============================================================================
# Teleport
#===============================================================================
#===============================================================================
# adding new methods in Script PItem_Items
# to include interacting via TELEPORTITEM from the bag
#===============================================================================
def canUseMoveTeleport?
   showmsg = true
   if !pbGetMetadata($game_map.map_id,MetadataOutdoor)
     Kernel.pbMessage(_INTL("Can't use that here.")) if showmsg
     return false
   end
   healing = $PokemonGlobal.healingSpot
   healing = pbGetMetadata(0,MetadataHome) if !healing   # Home
   if !healing
     Kernel.pbMessage(_INTL("Can't use that here.")) if showmsg
     return false
   end
   if $game_player.pbHasDependentEvents? && (IUSEFOLLOWINGPOKEMON ? !$game_switches[Following_Activated_Switch] : true)
     Kernel.pbMessage(_INTL("It can't be used when you have someone with you.")) if showmsg
     return false
   end
   return true
end

def confirmUseMoveTeleport
   healing = $PokemonGlobal.healingSpot
   healing = pbGetMetadata(0,MetadataHome) if !healing   # Home
   return false if !healing
   mapname = pbGetMapNameFromId(healing[0])
   return Kernel.pbConfirmMessage(_INTL("Want to return to the healing spot used last in {1}?",mapname))
end

def useMoveTeleport
   healing = $PokemonGlobal.healingSpot
   healing = pbGetMetadata(0,MetadataHome) if !healing   # Home
   return false if !healing
   if !pbHiddenMoveAnimation(nil)
     Kernel.pbMessage(_INTL("{1} used {2}!",$Trainer.name,PBItems.getName(PBItems::TELEPORTITEM)))
   end
   pbFadeOutIn(99999){
      $game_temp.player_new_map_id    = healing[0]
      $game_temp.player_new_x         = healing[1]
      $game_temp.player_new_y         = healing[2]
      $game_temp.player_new_direction = 2
      Kernel.pbCancelVehicles
      $scene.transfer_player
      $game_map.autoplay
      $game_map.refresh
   }
   pbEraseEscapePoint
   return true
end
 
#===============================================================================
# adding new ItemHandlers in the script PItem_ItemEffects
# for the Items to use them in the bag and in field
#===============================================================================
ItemHandlers::UseFromBag.add(:TELEPORTITEM,proc{|item|
   next canUseMoveTeleport? ? 2 : 0
})

ItemHandlers::UseInField.add(:TELEPORTITEM,proc{|item|
   useMoveTeleport if confirmUseMoveTeleport
})

#===============================================================================
# Waterfall
#===============================================================================
#===============================================================================
# overrides the method Kernel.pbWaterfall in Script PField_FieldMoves
# to include interacting via WATERFALLITEM with waterfalls on the map
#===============================================================================
def Kernel.pbWaterfall
  move = getID(PBMoves,:WATERFALL)
  movefinder = Kernel.pbCheckMove(move)
  if !pbCheckHiddenMoveBadge(BADGEFORWATERFALL,false) || (!$DEBUG && !movefinder && $PokemonBag.pbQuantity(PBItems::WATERFALLITEM)==0)
    Kernel.pbMessage(_INTL("A wall of water is crashing down with a mighty roar."))
    return false
  end
  if Kernel.pbConfirmMessage(_INTL("It's a large waterfall. Would you like to climb it?"))
    if $PokemonBag.pbQuantity(PBItems::WATERFALLITEM)>0
      Kernel.pbMessage(_INTL("{1} climbs the waterfall!",$Trainer.name))
      pbHiddenMoveAnimation(nil)
    else
      speciesname = (movefinder) ? movefinder.name : $Trainer.name
      Kernel.pbMessage(_INTL("{1} used {2}!",speciesname,PBMoves.getName(move)))
      pbHiddenMoveAnimation(movefinder)
    end
    pbAscendWaterfall
    return true
  end
  return false
end

#===============================================================================
# adding new methods in Script PItem_Items
# to include interacting via WATERFALLITEM from the bag
#===============================================================================
def canUseMoveWaterfall?
  showmsg = true
  return false if !pbCheckHiddenMoveBadge(BADGEFORWATERFALL,showmsg)
   if Kernel.pbFacingTerrainTag!=PBTerrain::Waterfall
     Kernel.pbMessage(_INTL("Can't use that here.")) if showmsg
     return false
   end
   return true
end

def useMoveWaterfall
   if !pbHiddenMoveAnimation(nil)
     Kernel.pbMessage(_INTL("{1} climbs the waterfall!",$Trainer.name))
   end
   Kernel.pbAscendWaterfall
   return true
end

#===============================================================================
# adding new ItemHandlers in the script PItem_ItemEffects
# for the Items to use them in the bag and in field
#===============================================================================
ItemHandlers::UseFromBag.add(:WATERFALLITEM,proc{|item|
   next canUseMoveWaterfall? ? 2 : 0
})

ItemHandlers::UseInField.add(:WATERFALLITEM,proc{|item|
   useMoveWaterfall if canUseMoveWaterfall?
})