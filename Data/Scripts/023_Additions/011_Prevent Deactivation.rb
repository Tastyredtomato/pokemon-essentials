=begin
================================================================================
 Prevent Deactivation
 Author: KK20
 Version: 1.1
--------------------------------------------------------------------------------
 [ Description ]
 When the game window is no longer the active window, it normally freezes the
 game from updating. This script will allow games to still run in the background.

 [ Instructions ]
 You can enable / disable this feature in-game using the script call:
 
              $game_system.keep_game_active = true / false
              
 This is useful for custom menu options so that the player can choose their
 preference of whether the game runs in the background or not.
 
 Script should be placed as low as possible in your script list, but still
 above Main.

 It is highly advised to not modify this script unless you know what you are
 doing.
================================================================================
=end

module MessageIntercept
  Start = Win32API.new('MessageIntercept', 'Init_Deactivate', 'pp', 'i')
  Toggle = Win32API.new('MessageIntercept', 'KeepGameActive', 'i', '')
  Flag_Deactivate = [1].pack('C*')
end

module Input
  class << self
    if @intercept_f12_stack.nil?
      alias update_if_game_in_focus update
      @intercept_f12_stack = true
    end
  end
  # Only accept player input if the game window is in focus
  def self.update
    update_if_game_in_focus if MessageIntercept::Flag_Deactivate[0] == 1
  end
end

class Game_System
  attr_reader :keep_game_active
  
  alias init_for_no_deactivate initialize
  def initialize
    @keep_game_active = true
    init_for_no_deactivate
  end
  
  # When loading a save, need to make DLL call to enable/disable keeping the
  # game active
  alias original_update_no_deactivate update
  def self.modify_update(revert = false)
    if revert
      alias update original_update_no_deactivate
    else
      alias update no_deactivate_update
    end
  end
  def no_deactivate_update
    MessageIntercept::Toggle.call(@keep_game_active ? 1 : 0)
    original_update_no_deactivate
    Game_System.modify_update(true)
  end
  
  def keep_game_active=(bool)
    @keep_game_active = bool
    MessageIntercept::Toggle.call(@keep_game_active ? 1 : 0)
  end
end

class Game_Temp
  alias change_gamesystem_update_init initialize
  def initialize
    change_gamesystem_update_init
    Game_System.modify_update
  end
end

if MessageIntercept::Start.call('.\\Game.ini', MessageIntercept::Flag_Deactivate) == -1
  raise 'ERROR: Prevent Deactivation failed to set new window procedure!'
end
