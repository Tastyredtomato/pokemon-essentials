#---------------------------------------------
# UNOWN DEX
# Code by: TastyRedTomato
#---------------------------------------------
# Call as pbUnownDex
# 
#---------------------------------------------

class UnownDex_Scene
  def pbUpdate
    pbUpdateSpriteHash(@sprites)
  end
  
  def pbStartScene(commands)
    @commands = commands
    @viewport = Viewport.new(0,0,Graphics.width,Graphics.height)
    @viewport.z = 99999
    @sprites = {}
    @sprites["background"] = IconSprite.new(0,0,@viewport)
    @sprites["background"].setBitmap("Graphics/Pictures/Unownbg")
    @sprites["header"] = Window_UnformattedTextPokemon.newWithSize(
       _INTL("Unown Report"),2,-18,256,64,@viewport)
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

class UnownDexScreen
  def initialize(scene)
    @scene = scene
  end
  
  def pbStartScreen
    commands = []
    cmdA = -1
    cmdB = -1
    cmdC = -1
    cmdD = -1
    cmdE = -1
    cmdF = -1
    cmdG = -1
    cmdH = -1
    cmdI = -1
    cmdJ = -1
    cmdK = -1
    cmdL = -1
    cmdM = -1
    cmdN = -1
    cmdO = -1
    cmdP = -1
    cmdQ = -1
    cmdR = -1
    cmdS = -1
    cmdT = -1
    cmdU = -1
    cmdV = -1
    cmdW = -1
    cmdX = -1
    cmdY = -1
    cmdZ = -1
    cmdQues = -1
    cmdEx = -1
    cmdexit = -1
    if $Trainer.formseen[201][2][0] == true
      commands[cmdA = commands.length] = ["A",_INTL("A")]
    end
    if $Trainer.formseen[201][2][1] == true
      commands[cmdB = commands.length] = ["B",_INTL("B")]
    end
    if $Trainer.formseen[201][2][2] == true
      commands[cmdC = commands.length] = ["C",_INTL("C")]
    end
    if $Trainer.formseen[201][2][3] == true
      commands[cmdD = commands.length] = ["D",_INTL("D")]
    end
    if $Trainer.formseen[201][2][4] == true
      commands[cmdE = commands.length] = ["E",_INTL("E")]
    end
    if $Trainer.formseen[201][2][5] == true
      commands[cmdF = commands.length] = ["F",_INTL("F")]
    end
    if $Trainer.formseen[201][2][6] == true
      commands[cmdG = commands.length] = ["G",_INTL("G")]
    end
    if $Trainer.formseen[201][2][7] == true
      commands[cmdH = commands.length] = ["H",_INTL("H")]
    end
    if $Trainer.formseen[201][2][8] == true
      commands[cmdI = commands.length] = ["I",_INTL("I")]
    end
    if $Trainer.formseen[201][2][9] == true
      commands[cmdJ = commands.length] = ["J",_INTL("J")]
    end
    if $Trainer.formseen[201][2][10] == true
      commands[cmdK = commands.length] = ["K",_INTL("K")]
    end
    if $Trainer.formseen[201][2][11] == true
      commands[cmdL = commands.length] = ["L",_INTL("L")]
    end
    if $Trainer.formseen[201][2][12] == true
      commands[cmdM = commands.length] = ["M",_INTL("M")]
    end
    if $Trainer.formseen[201][2][13] == true
      commands[cmdN = commands.length] = ["N",_INTL("N")]
    end
    if $Trainer.formseen[201][2][14] == true
      commands[cmdO = commands.length] = ["O",_INTL("O")]
    end
    if $Trainer.formseen[201][2][15] == true
      commands[cmdP = commands.length] = ["P",_INTL("P")]
    end
    if $Trainer.formseen[201][2][16] == true
      commands[cmdQ = commands.length] = ["Q",_INTL("Q")]
    end
    if $Trainer.formseen[201][2][17] == true
      commands[cmdR = commands.length] = ["R",_INTL("R")]
    end
    if $Trainer.formseen[201][2][18] == true
      commands[cmdS = commands.length] = ["S",_INTL("S")]
    end
    if $Trainer.formseen[201][2][19] == true
      commands[cmdT = commands.length] = ["T",_INTL("T")]
    end
    if $Trainer.formseen[201][2][20] == true
      commands[cmdU = commands.length] = ["U",_INTL("U")]
    end
    if $Trainer.formseen[201][2][21] == true
      commands[cmdV = commands.length] = ["V",_INTL("V")]
    end
    if $Trainer.formseen[201][2][22] == true
      commands[cmdW = commands.length] = ["W",_INTL("W")]
    end
    if $Trainer.formseen[201][2][23] == true
      commands[cmdX = commands.length] = ["X",_INTL("X")]
    end
    if $Trainer.formseen[201][2][24] == true
      commands[cmdY = commands.length] = ["Y",_INTL("Y")]
    end
    if $Trainer.formseen[201][2][25] == true
      commands[cmdZ = commands.length] = ["Z",_INTL("Z")]
    end
    if $Trainer.formseen[201][2][26] == true
      commands[cmdQues = commands.length] = ["?",_INTL("?")]
    end
    if $Trainer.formseen[201][2][27] == true
      commands[cmdEx = commands.length] = ["!",_INTL("!")]
    end
    commands[cmdExit = commands.length] = ["Exit",_INTL("Exit")]
    
    @scene.pbStartScene(commands)
    loop do
      cmd = @scene.pbScene
      if cmd<0
        pbPlayCancelSE
        break
      elsif cmdA>=0 && cmd==A
        pbPlayDecisionSE
        Kernel.pbMessage(_INTL("A unown"))
      elsif cmdB>=0 && cmd==B
        pbPlayDecisionSE
        Kernel.pbMessage(_INTL("B unown"))
      elsif cmdC>=0 && cmd==C
        pbPlayDecisionSE
        Kernel.pbMessage(_INTL("C unown"))
      elsif cmdD>=0 && cmd==cmdD
        pbPlayDecisionSE
        Kernel.pbMessage(_INTL("D unown"))
      elsif cmdE>=0 && cmd==cmdE
        pbPlayDecisionSE
        Kernel.pbMessage(_INTL("E unown"))
      elsif cmdF>=0 && cmd==cmdF
        pbPlayDecisionSE
        Kernel.pbMessage(_INTL("F unown"))
      elsif cmdG>=0 && cmd==cmdG
        pbPlayDecisionSE
        Kernel.pbMessage(_INTL("G unown"))
      elsif cmdH>=0 && cmd==cmdH
        pbPlayDecisionSE
        Kernel.pbMessage(_INTL("H unown"))
      elsif cmdI>=0 && cmd==cmdI
        pbPlayDecisionSE
        Kernel.pbMessage(_INTL("I unown"))
      elsif cmdJ>=0 && cmd==cmdJ
        pbPlayDecisionSE
        Kernel.pbMessage(_INTL("J unown"))
      elsif cmdK>=0 && cmd==cmdK
        pbPlayDecisionSE
        Kernel.pbMessage(_INTL("K unown"))
      elsif cmdL>=0 && cmd==cmdL  
        pbPlayDecisionSE
        Kernel.pbMessage(_INTL("L unown"))
      elsif cmdM>=0 && cmd==cmdM
        pbPlayDecisionSE
        Kernel.pbMessage(_INTL("M unown"))
      elsif cmdN>=0 && cmd==cmdN
        pbPlayDecisionSE
        Kernel.pbMessage(_INTL("N unown"))
      elsif cmdO>=0 && cmd==cmdO
        pbPlayDecisionSE
        Kernel.pbMessage(_INTL("O unown"))
      elsif cmdP>=0 && cmd==cmdP
        pbPlayDecisionSE
        Kernel.pbMessage(_INTL("P unown"))
      elsif cmdQ>=0 && cmd==cmdQ
        pbPlayDecisionSE
        Kernel.pbMessage(_INTL("Q unown"))
      elsif cmdR>=0 && cmd==cmdR
        pbPlayDecisionSE
        Kernel.pbMessage(_INTL("R unown"))
      elsif cmdS>=0 && cmd==cmdS
        pbPlayDecisionSE
        Kernel.pbMessage(_INTL("S unown"))
      elsif cmdT>=0 && cmd==cmdT
        pbPlayDecisionSE
        Kernel.pbMessage(_INTL("T unown"))
      elsif cmdU>=0 && cmd==cmdU
        pbPlayDecisionSE
        Kernel.pbMessage(_INTL("U unown"))
      elsif cmdV>=0 && cmd==cmdV
        pbPlayDecisionSE
        Kernel.pbMessage(_INTL("V unown"))
      elsif cmdW>=0 && cmd==cmdW
        pbPlayDecisionSE
        Kernel.pbMessage(_INTL("W unown"))
      elsif cmdX>=0 && cmd==cmdX
        pbPlayDecisionSE
        Kernel.pbMessage(_INTL("X unown"))
      elsif cmdY>=0 && cmd==cmdY
        pbPlayDecisionSE
        Kernel.pbMessage(_INTL("Y unown"))
      elsif cmdZ>=0 && cmd==cmdZ
        pbPlayDecisionSE
        Kernel.pbMessage(_INTL("Z unown"))
      elsif cmdQues>=0 && cmd==cmdQues
        pbPlayDecisionSE
        Kernel.pbMessage(_INTL("? unown"))
      elsif cmdEx>=0 && cmd==cmdEx
        pbPlayDecisionSE
        Kernel.pbMessage(_INTL("! unown"))
      elsif cmdExit>=0 && cmd==cmdExit
        pbPlayDecisionSE
        break
      end
    end
    @scene.pbEndScene
  end
end