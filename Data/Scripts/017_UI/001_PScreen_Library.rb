##=##===========================================================================
##=## Easy Questing System - made by M3rein
##=##===========================================================================
##=## Create your own books starting from line 72. Be aware of the following:
##=## * Every book should have a unique ID;
##=## * Every book should be unique (at least one field has to be different);
##=## * The "Name" field can't be very long;
##=## * The "Desc" field can be quite long;
##=## * The "NPC" field is JUST a name;
##=## * The "Sprite" field is the name of the sprite in "Graphics/Characters";
##=## * The "Location" field is JUST a name;
##=## * The "Color" field is a SYMBOL (starts with ':'). List under "pbColor";
##=## * The "Time" field can be a random string for it to be "?????" in-game;
##=## * The "Completed" field can be pre-set, but is normally only changed in-game
##=##===========================================================================
#Library conversion by TastyRedTomato
#Use following commands to add or remove books:
#pbAddBook(id)   adds book with the specified id to the library, standard category is books
#pbSetBook(id, tutorial)    set the book of specified id to be part of the tutorial category when true or part of the standard category when false
#pbDeleteBook(id)    remove a book with the specified id from the library
#
#other commands can be used as well to change book values throughout the game, see definitions starting with pb
##==============================================================================

class Book
  attr_accessor :id
  attr_accessor :name
  attr_accessor :desc
  attr_accessor :npc
  attr_accessor :sprite
  attr_accessor :location
  attr_accessor :color
  attr_accessor :time
  attr_accessor :tutorial
  def initialize(id, name, desc, npc, sprite, location, color = :WHITE, time = Time.now, tutorial = false)
    self.id = id
    self.name = name
    self.desc = desc
    self.npc = npc
    self.sprite = sprite
    self.location = location
    self.color = pbColor(color)
    self.time = time
    self.tutorial = tutorial
  end
end

def pbColor(color)
  # Mix your own colors: http://www.rapidtables.com/web/color/RGB_Color.htm
  return Color.new(0,0,0)         if color == :BLACK
  return Color.new(255,115,115)   if color == :LIGHTRED
  return Color.new(245,11,11)     if color == :RED
  return Color.new(164,3,3)       if color == :DARKRED
  return Color.new(47,46,46)      if color == :DARKGREY
  return Color.new(100,92,92)     if color == :LIGHTGREY
  return Color.new(226,104,250)   if color == :PINK
  return Color.new(243,154,154)   if color == :PINKTWO
  return Color.new(255,160,50)    if color == :GOLD
  return Color.new(255,186,107)   if color == :LIGHTORANGE
  return Color.new(95,54,6)       if color == :BROWN
  return Color.new(122,76,24)     if color == :LIGHTBROWN
  return Color.new(255,246,152)   if color == :LIGHTYELLOW
  return Color.new(242,222,42)    if color == :YELLOW
  return Color.new(80,111,6)      if color == :DARKGREEN
  return Color.new(154,216,8)     if color == :GREEN
  return Color.new(197,252,70)    if color == :LIGHTGREEN
  return Color.new(74,146,91)     if color == :FADEDGREEN
  return Color.new(6,128,92)      if color == :DARKLIGHTBLUE
  return Color.new(18,235,170)    if color == :LIGHTBLUE
  return Color.new(139,247,215)   if color == :SUPERLIGHTBLUE
  return Color.new(35,203,255)    if color == :BLUE
  return Color.new(3,44,114)      if color == :DARKBLUE
  return Color.new(7,3,114)       if color == :SUPERDARKBLUE
  return Color.new(63,6,121)      if color == :DARKPURPLE
  return Color.new(113,16,209)    if color == :PURPLE
  return Color.new(219,183,37)    if color == :ORANGE
  return Color.new(255,255,255)
end

BOOKS = [
# Make sure you take into account all the information given at the top of this script.
# You don't have to give the Quest a color - :SUPERLIGHTBLUE in this example. It will default to White.
   Book.new(1, "Mart Monthly January", "This month's feature is the Poké Ball! A staple in any Trainer's arsenal, there are many different balls to be found.", "Book Source", "book1", "Book Location", :WHITE),
   Book.new(2, "Mart Monthly February", "This month's feature is the Potion! Potions exist in many varieties. These curatives are produced using herbs found in the wilderness.", "PokéMart Assistant", "book1", "Route 1", :WHITE),
   Book.new(3, "Mart Monthly March", "This month's feature is the Repel! Stuck in the wilderness and low on health? A Repel may be the thing that saves your life. This spray can keep wild Pokémon at bay for a certain period of time.", "Book Source", "book1", "Book Location", :WHITE),
   Book.new(4, "Mart Monthly April", "This month's feature are our status curatives! A trainer journey around the content takes you around the continent and many different biomes. The PokéMart sells Burn Heals, Ice Heals, Antidotes and more.", "Book Source", "book1", "Book Location", :WHITE),
   Book.new(5, "Mart Monthly May", "This month we feature the opening of our brand new store in Galancia Gardens. This store features a range of foreign products not seen elsewhere. It helps you train your Pokémon in preparation of the League!", "Book Source", "book1", "Book Location", :WHITE),
   Book.new(6, "Mart Monthly June", "Did you know? You can sell many items in the PokéMarts! We buy everything at half the market value so if you have any items you can find no use for we are glad to take them off your hands.", "Bookcase", "book1", "Tidal Town", :WHITE),
   Book.new(7, "Mart Monthly July", "This month's feature is the Mystery Gift! In any of our stores you can sign up to our Mystery Gift Program where benefactors sponsor trainers with gifts. Be sure to check every now and then!", "Book Source", "book1", "Book Location", :WHITE),
   Book.new(8, "Mart Monthly August", "This month's feature is the Escape Rope! A handy rope which can help you find the exit to a cavern in mere seconds, this item is very useful if you don't feel like walking all the way back.", "Book Source", "book1", "Book Location", :WHITE),
   Book.new(9, "Mart Monthly September", "This month's feature is about or very own Premier Ball! Buying in bulk has its benefits. Buy 10 or more Pokéballs at once and we throw in a Premier Ball for free!", "Book Source", "book1", "Book Location", :WHITE),
   Book.new(10, "Mart Monthly October", "Did you know? Most of our products are produced by the Devon or Silph Corporations. These great corporations supply our marts all over the world!", "Bookcase", "book1", "Tidal Town", :WHITE),
   Book.new(11, "Mart Monthly November", "Did you know? The first PokéMart was founded in the Kanto Region in the east. We try to provide an equally good service everywhere you go!", "Book Source", "book1", "Book Location", :WHITE),
   Book.new(12, "Mart Monthly December", "Did you know? Collect all the Mart Monthly's of a year and you might be eligible for a prize in our new department store in Galancia Gardens!", "Book Source", "book1", "Book Location", :WHITE),
   Book.new(13, "Card Club Maniacs 1", "PokéTriad is the new up and coming game in Netivih! I've heard they're handing out binders in the Lumishore Casino...", "Card Club Maniac", "book1", "Hedge Point", :WHITE),
   Book.new(14, "Card Club Maniacs 2", "PokéTriad is easy to learn but hard to master. Just get a higher value than the opponent right? Wrong! There are so many rules out there. Same, Elements, Wrap, Open, Random, Unplayed, All and Direct.", "Book Source", "book1", "Book Location", :WHITE),
   Book.new(15, "Card Club Maniacs 3", "Have you heard of character cards? They're cards that don't depict Pokémon but people! Crazy right? They're supposedly incredibly powerful...", "Book Source", "book1", "Book Location", :WHITE),
   Book.new(16, "Card Club Maniacs 4", "Cards are fun and all but it's serious business. You can get real items with them. Either from the tournaments in Canalis City or from people willing to trade.", "Book Source", "book1", "Book Location", :WHITE),
   Book.new(17, "Card Club Maniacs 5", "There's some dude out there. They call him the Collector and he has some of the rarest cards you've ever seen. But he will only play select people who prove themselves.", "Book Source", "book1", "Book Location", :WHITE),
   Book.new(18, "Card Club Maniacs 6", "I'll tell you about Combos. They only happen under the Same rule. When you play a card and Same applies, the flipped card will flip all adjacent cards it can beat. Though it won't use the Same rule again!", "Book Source", "book1", "Book Location", :WHITE),
   Book.new(19, "Legendary Lovers Vol 1", "People took some blurry photos of a creature near the Great Dam. Now if only there were some way to get down there properly...", "Bookcase", "book1", "S.S.Eliza", :WHITE),
   Book.new(20, "Legendary Lovers Vol 2", "Does anyone want to investigate Bell Lake with me? I swear that warm water is not natural in this climate...", "Book Source", "book1", "Book Location", :WHITE),
   Book.new(21, "Legendary Lovers Vol 3", "I've heard of a legendary creature living in the Polder Reserve. Some rare bird maybe? If only they didn't limit the distance I can travel.", "Mr. Fulton", "book1", "Milldam City", :WHITE),
   Book.new(22, "Legendary Lovers Vol 4", "Folks have reported a moving shadow under the ice of Yssel Lake. I've asked around and it's always been there but I'm sure it's something!", "Bookcase", "book1", "Canalis City", :WHITE),
   Book.new(23, "Legendary Lovers Vol 5", "North of Tidal Town there is a glacier and legend goes a Pokémon was frozen in the ice. If only it wasn't so cold I would try to get a look at it.", "Bookcase", "book1", "Tidal Town", :WHITE),
   Book.new(24, "Pokémon Care I: by Brock", "How to groom your Vulpix: The choice of brush is important when taking care of a Vulpix. Too hard will damage the fur and irritate the fur. Too soft will just annoy the Pokémon.", "Bookcase", "book1", "Pokémon Daycare", :WHITE),
   Book.new(25, "Fishing 101", "There are 3 different types of rods. The Old Rod is what every fisherman starts out with. You'll capture karp but you might get lucky. If you want other Pokémon you need better rods, like the Good Rod or the Super Rod.", "Bookcase", "book1", "Bell Town", :WHITE),
   Book.new(26, "Pokémon Care II: by Nessa", "Fish Pokémon and their evolutions by Nessa: Magikarp is often deemed a useless Pokémon. Its evolution, Gyarados, can be a frightening appearance however. When it uses its signature move Dragon Rage you better hold onto something.", "Bookcase", "book1", "S.S. Eliza", :WHITE),
   Book.new(27, "Pokémon Care III: by Sabrina", "My kadabra and I volunteered to assist in psycho-therapy programs. We hope to help children with the potential of Pokémon instead of using them for fighting.", "Bookcase", "book1", "Tidal Town", :WHITE),
   Book.new(28, "Pokémon Care IV: by Brock", "Pokémon love my food! Especially my Rice Balls. One day I found Pikachu sneaking through my bag, thinking there was something to score.", "Bookcase", "book1", "Lyre Town", :WHITE),
   Book.new(29, "Legendary Lovers Vol 6", "I've heard the Pokémon Celebi only comes when the flowers fall. But not always, and not for just anyone!", "Bookcase", "book1", "Floralia Town", :WHITE),
   Book.new(30, "Chronicle of disaster V", "And the old men saw the bodies of the young, but learned nothing because they had won a great victory.","Wall Glyphs", "book1", "Harrow's Descent Archives", :WHITE),
   Book.new(31, "Chronicle of disaster II", "Then that day from the east they came, with man and Pokémon suited for battle, stirred by vile propaganda.","Wall Glyphs", "book1", "Harrow's Descent Archives", :WHITE),
   Book.new(32, "Chronicle of disaster I", "Witness here, the chronicle of disaster which befell our region, and remind future generations to utter this cry: war nevermore.","Wall Glyphs", "book1", "Harrow's Descent Archives", :WHITE),
   Book.new(33, "Chronicle of disaster III", "And from our side the old men spoke to the young. Go, take your Pokémon you have trained so well and defend the fatherland.","Wall Glyphs", "book1", "Harrow's Descent Archives", :WHITE),
   Book.new(34, "Chronicle of disaster IV", "But both sides spilt bitter blood, which only fed the flowers of this blasted Earth.","Wall Glyphs", "book1", "Harrow's Descent Archives", :WHITE),
   Book.new(35, "Chronicle of disaster VI", "Yet know this, that war knows no victors.","Wall Glyphs", "book1", "Harrow's Descent Archives", :WHITE),
   Book.new(36, "Diggers Digest 1", "Trade Stones are pretty valuable, they evolve Pokémon that evolve through trading. Find Hikers with blue helmets to help you use them.","Hiker", "book1", "Bell Town", :WHITE),
]

class PokeBattle_Trainer
  attr_accessor :books
end

def pbTutorialBook?(id)
  $Trainer.books = [] if $Trainer.books.class == NilClass
  for i in 0...$Trainer.books.size
    return true if $Trainer.books[i].tutorial && $Trainer.books[i].id == id
  end
  return false
end

def pbBooklog
  Booklog.new
end

def pbAddBook(id)
  Kernel.pbMessage(_INTL("A new book was added to the PokéGear!"))
  $Trainer.books = [] if $Trainer.books.class == NilClass
  for q in BOOKS
    $Trainer.books << q if q.id == id
  end
end

def pbDeleteBook(id)
  $Trainer.books = [] if $Trainer.books.class == NilClass
  for q in $Trainer.books
    $Trainer.books.delete(q) if q.id == id
  end
end

def pbSetBook(id, tutorial)
  $Trainer.books = [] if $Trainer.books.class == NilClass
  for q in $Trainer.books
    q.tutorial = tutorial if q.id == id
  end
end

def pbSetBookName(id, name)
  $Trainer.books = [] if $Trainer.books.class == NilClass
  for q in $Trainer.books
    q.name = name if q.id == id
  end
end

def pbSetBookDesc(id, desc)
  $Trainer.books = [] if $Trainer.books.class == NilClass
  for q in $Trainer.books
    q.desc = desc if q.id == id
  end
end

def pbSetBookNPC(id, npc)
  $Trainer.books = [] if $Trainer.books.class == NilClass
  for q in $Trainer.books
    q.npc = npc if q.id == id
  end
end

def pbSetBookNPCSprite(id, sprite)
  $Trainer.books = [] if $Trainer.books.class == NilClass
  for q in $Trainer.books
    q.sprite = sprite if q.id == id
  end
end

def pbSetBookLocation(id, location)
  $Trainer.books = [] if $Trainer.books.class == NilClass
  for q in $Trainer.books
    q.location = location if q.id == id
  end
end

def pbSetBookColor(id, color)
  $Trainer.books = [] if $Trainer.books.class == NilClass
  for q in $Trainer.books
    q.color = pbColor(color) if q.id == id
  end
end

class BookSprite < IconSprite
  attr_accessor :book
end

class Booklog
  def initialize
    $Trainer.books = [] if $Trainer.books.class == NilClass
    @page = 0
    @sel_one = 0
    @sel_two = 0
    @scene = 0
    @mode = 0
    @box = 0
    @tutorial = []
    @book = []
    for q in $Trainer.books
      @book << q if !q.tutorial
      @tutorial << q if q.tutorial
    end
    @viewport = Viewport.new(0, 0, Graphics.width, Graphics.height)
    @viewport.z = 99999
    @sprites = {}
    @sprites["main"] = BitmapSprite.new(Graphics.width, Graphics.height, @viewport)
    @sprites["main"].z = 1
    @sprites["main"].opacity = 0
    @main = @sprites["main"].bitmap
    pbSetSystemFont(@main)
    pbDrawOutlineText(@main,0,2-178,512,384,"Books",Color.new(255,255,255),Color.new(0,0,0),1)
    
    @sprites["bg0"] = IconSprite.new(0, 0, @viewport)
    @sprites["bg0"].setBitmap("Graphics/Pictures/pokegearbg")
    @sprites["bg0"].opacity = 0
    
    for i in 0..1
      @sprites["btn#{i}"] = IconSprite.new(0, 0, @viewport)
      @sprites["btn#{i}"].setBitmap("Graphics/Pictures/bookBtn")
      @sprites["btn#{i}"].x = 84
      @sprites["btn#{i}"].y = 130 + 56 * i
      @sprites["btn#{i}"].src_rect.height = (@sprites["btn#{i}"].bitmap.height / 2).round
      @sprites["btn#{i}"].src_rect.y = i == 0 ? (@sprites["btn#{i}"].bitmap.height / 2).round : 0
      @sprites["btn#{i}"].opacity = 0
    end
    pbDrawOutlineText(@main,0,142-178,512,384,"Books: " + @book.size.to_s,Color.new(255,255,255),Color.new(0,0,0),1)
    pbDrawOutlineText(@main,0,198-178,512,384,"Tutorials: " + @tutorial.size.to_s,Color.new(255,255,255),Color.new(0,0,0),1)

    12.times do |i|
      Graphics.update
      @sprites["bg0"].opacity += 32 if i < 8
      @sprites["btn0"].opacity += 32 if i > 3
      @sprites["btn1"].opacity += 32 if i > 3
      @sprites["main"].opacity += 64 if i > 7
    end
    pbUpdate
  end
  
  def pbUpdate
    @frame = 0
    loop do
      @frame += 1
      Graphics.update
      Input.update
      if @scene == 0
        break if Input.trigger?(Input::B)
        pbList(@sel_one) if Input.trigger?(Input::C)
        pbSwitch(:DOWN) if Input.trigger?(Input::DOWN)
        pbSwitch(:UP) if Input.trigger?(Input::UP)
      end
      if @scene == 1
        pbMain if Input.trigger?(Input::B)
        pbMove(:DOWN) if Input.trigger?(Input::DOWN)
        pbMove(:UP) if Input.trigger?(Input::UP)
        pbLoad(0) if Input.trigger?(Input::C)
	pbArrows
      end
      if @scene == 2
        pbList(@sel_one) if Input.trigger?(Input::B)
        pbChar if @frame == 6 || @frame == 12 || @frame == 18
        pbLoad(1) if Input.trigger?(Input::RIGHT) && @page == 0
        pbLoad(2) if Input.trigger?(Input::LEFT) && @page == 1
      end
      @frame = 0 if @frame == 18
    end
    pbEnd
    pbDisposeSpriteHash(@sprites)
    @viewport.dispose
    pbWait(1)
  end
	
  def pbArrows
    if @frame == 2 || @frame == 4 || @frame == 14 || @frame == 16
      @sprites["up"].y -= 1 rescue nil
      @sprites["down"].y -= 1 rescue nil
    elsif @frame == 6 || @frame == 8 || @frame == 10 || @frame == 12
      @sprites["up"].y += 1 rescue nil
       @sprites["down"].y += 1 rescue nil
    end
  end
	
  def pbLoad(page)
    return if @mode == 0 ? @book.size == 0 : @tutorial.size == 0
    book = @mode == 0 ? @book[@sel_two] : @tutorial[@sel_two]
    pbWait(1)
    if page == 0
      @scene = 2
      @sprites["bg1"] = IconSprite.new(0, 0, @viewport)
      @sprites["bg1"].setBitmap("Graphics/Pictures/bookPage1")
      @sprites["bg1"].opacity = 0
      @sprites["pager"] = IconSprite.new(0, 0, @viewport)
      @sprites["pager"].setBitmap("Graphics/Pictures/bookPager")
      @sprites["pager"].x = 442
      @sprites["pager"].y = 3
      @sprites["pager"].z = 1
      @sprites["pager"].opacity = 0
      8.times do
        Graphics.update
	@sprites["up"].opacity -= 32
	@sprites["down"].opacity -= 32
        @sprites["main"].opacity -= 32
        @sprites["bg1"].opacity += 32
        @sprites["pager"].opacity += 32
        @sprites["char"].opacity -= 32 rescue nil
        for i in 0...@book.size
	  break if i > 5
          @sprites["book#{i}"].opacity -= 32 rescue nil
        end
        for i in 0...@tutorial.size
	  break if i > 5
          @sprites["tutorial#{i}"].opacity -= 32 rescue nil
        end
      end
      @sprites["up"].dispose
      @sprites["down"].dispose
      @sprites["char"] = IconSprite.new(0, 0, @viewport)
      @sprites["char"].setBitmap("Graphics/Characters/#{book.sprite}")
      @sprites["char"].x = 62
      @sprites["char"].y = 130
      @sprites["char"].src_rect.height = (@sprites["char"].bitmap.height / 4).round
      @sprites["char"].src_rect.width = (@sprites["char"].bitmap.width / 4).round
      @sprites["char"].opacity = 0
      @main.clear
      @text.clear rescue nil
      @text2.clear rescue nil
      drawTextExMulti(@main,188,54,318,8,book.desc,Color.new(255,255,255),Color.new(0,0,0))
      pbDrawOutlineText(@main,188,162,512,384,"From " + book.npc,Color.new(255,172,115),Color.new(0,0,0))
      pbDrawOutlineText(@main,10,-178,512,384,book.name,book.color,Color.new(0,0,0))
      if !book.tutorial
        pbDrawOutlineText(@main,8,136,512,384,"Book",pbColor(:LIGHTRED),Color.new(0,0,0))
      else
        pbDrawOutlineText(@main,8,136,512,384,"Tutorial",pbColor(:LIGHTBLUE),Color.new(0,0,0))
      end
      10.times do |i|
        Graphics.update
        @sprites["main"].opacity += 32
        @sprites["char"].opacity += 32 if i > 1
      end
    elsif page == 1
      @page = 1
      @sprites["bg2"] = IconSprite.new(0, 0, @viewport)
      @sprites["bg2"].setBitmap("Graphics/Pictures/bookPage1")
      @sprites["bg2"].x = 512
      @sprites["pager2"] = IconSprite.new(0, 0, @viewport)
      @sprites["pager2"].setBitmap("Graphics/Pictures/bookPager")
      @sprites["pager2"].x = 474 + 512
      @sprites["pager2"].y = 3
      @sprites["pager2"].z = 1
      @sprites["char2"].dispose rescue nil
      @sprites["char2"] = IconSprite.new(0, 0, @viewport)
      @sprites["char2"].setBitmap("Graphics/Characters/#{book.sprite}")
      @sprites["char2"].x = 62 + 512
      @sprites["char2"].y = 130
      @sprites["char2"].z = 1
      @sprites["char2"].src_rect.height = (@sprites["char2"].bitmap.height / 4).round
      @sprites["char2"].src_rect.width = (@sprites["char2"].bitmap.width / 4).round
      @sprites["text2"] = IconSprite.new(@viewport)
      @sprites["text2"].bitmap = Bitmap.new(Graphics.width,Graphics.height)
      @text2 = @sprites["text2"].bitmap
      pbSetSystemFont(@text2)
      pbDrawOutlineText(@text2,188,-122,512,384,"Book received in:",Color.new(255,255,255),Color.new(0,0,0))
      pbDrawOutlineText(@text2,188,-94,512,384,book.location,Color.new(255,172,115),Color.new(0,0,0))
      pbDrawOutlineText(@text2,188,-62,512,384,"Book received at:",Color.new(255,255,255),Color.new(0,0,0))
      time = book.time.to_s
      txt = time.split(' ')[1] + " " + time.split(' ')[2] + ", " + time.split(' ')[3].split(':')[0] + ":" + time.split(' ')[3].split(':')[1] rescue "?????"
      pbDrawOutlineText(@text2,188,-36,512,384,txt,Color.new(255,172,115),Color.new(0,0,0))
      pbDrawOutlineText(@text2,188,-4,512,384,"Book received from:",Color.new(255,255,255),Color.new(0,0,0))
      pbDrawOutlineText(@text2,188,22,512,384,book.npc,Color.new(255,172,115),Color.new(0,0,0))
      pbDrawOutlineText(@text2,188,162,512,384,"From " + book.npc,Color.new(255,172,115),Color.new(0,0,0))
      pbDrawOutlineText(@text2,10,-178,512,384,book.name,book.color,Color.new(0,0,0))
      if !book.tutorial
        pbDrawOutlineText(@text2,8,136,512,384,"Book",pbColor(:LIGHTRED),Color.new(0,0,0))
      else
        pbDrawOutlineText(@text2,8,136,512,384,"Tutorial",pbColor(:LIGHTBLUE),Color.new(0,0,0))
      end
      @sprites["text2"].x = 512
      16.times do
        Graphics.update
        @sprites["bg1"].x -= (@sprites["bg1"].x + 526) * 0.2
        @sprites["pager"].x -= (@sprites["pager"].x + 526) * 0.2 rescue nil
        @sprites["char"].x -= (@sprites["char"].x + 526) * 0.2 rescue nil
        @sprites["main"].x -= (@sprites["main"].x + 526) * 0.2
        @sprites["text"].x -= (@sprites["text"].x + 526) * 0.2 rescue nil
        @sprites["bg2"].x -= (@sprites["bg2"].x + 14) * 0.2
        @sprites["pager2"].x -= (@sprites["pager2"].x - 459) * 0.2
        @sprites["text2"].x -= (@sprites["text2"].x + 14) * 0.2
        @sprites["char2"].x -= (@sprites["char2"].x - 47) * 0.2
      end
      @sprites["main"].x = 0
      @main.clear
    else
      @page = 0
      @sprites["bg1"] = IconSprite.new(0, 0, @viewport)
      @sprites["bg1"].setBitmap("Graphics/Pictures/bookPage1")
      @sprites["bg1"].x = -512
      @sprites["pager"] = IconSprite.new(0, 0, @viewport)
      @sprites["pager"].setBitmap("Graphics/Pictures/bookPager")
      @sprites["pager"].x = 442 - 512
      @sprites["pager"].y = 3
      @sprites["pager"].z = 1
      @sprites["text"] = IconSprite.new(@viewport)
      @sprites["text"].bitmap = Bitmap.new(Graphics.width,Graphics.height)
      @text = @sprites["text"].bitmap
      pbSetSystemFont(@text)
      @sprites["char"].dispose rescue nil
      @sprites["char"] = IconSprite.new(0, 0, @viewport)
      @sprites["char"].setBitmap("Graphics/Characters/#{book.sprite}")
      @sprites["char"].x = 62 - 512
      @sprites["char"].y = 130
      @sprites["char"].z = 1
      @sprites["char"].src_rect.height = (@sprites["char"].bitmap.height / 4).round
      @sprites["char"].src_rect.width = (@sprites["char"].bitmap.width / 4).round
      drawTextExMulti(@text,188,54,318,8,book.desc,Color.new(255,255,255),Color.new(0,0,0))
      pbDrawOutlineText(@text,188,162,512,384,"From " + book.npc,Color.new(255,172,115),Color.new(0,0,0))
      pbDrawOutlineText(@text,10,-178,512,384,book.name,book.color,Color.new(0,0,0))
      if !book.tutorial
        pbDrawOutlineText(@text,8,136,512,384,"Book",pbColor(:LIGHTRED),Color.new(0,0,0))
      else
        pbDrawOutlineText(@text,8,136,512,384,"Tutorial",pbColor(:LIGHTBLUE),Color.new(0,0,0))
      end
      @sprites["text"].x = -512
      16.times do
        Graphics.update
        @sprites["bg1"].x -= (@sprites["bg1"].x - 14) * 0.2
        @sprites["pager"].x -= (@sprites["pager"].x - 457) * 0.2
        @sprites["bg2"].x -= (@sprites["bg2"].x - 526) * 0.2
        @sprites["pager2"].x -= (@sprites["pager2"].x - 526) * 0.2
        @sprites["char2"].x -= (@sprites["char2"].x - 526) * 0.2
        @sprites["text2"].x -= (@sprites["text2"].x - 526) * 0.2
        @sprites["text"].x -= (@sprites["text"].x - 15) * 0.2
        @sprites["char"].x -= (@sprites["char"].x - 76) * 0.2
      end
    end
  end
  
  def pbChar
    @sprites["char"].src_rect.x += (@sprites["char"].bitmap.width / 4).round rescue nil
    @sprites["char"].src_rect.x = 0 if @sprites["char"].src_rect.x >= @sprites["char"].bitmap.width rescue nil
    @sprites["char2"].src_rect.x += (@sprites["char2"].bitmap.width / 4).round rescue nil
    @sprites["char2"].src_rect.x = 0 if @sprites["char2"].src_rect.x >= @sprites["char2"].bitmap.width rescue nil
  end
  
  def pbMain
    pbWait(1)
    12.times do |i|
      Graphics.update
      @sprites["main"].opacity -= 32 rescue nil
      @sprites["bg0"].opacity += 32 if @sprites["bg0"].opacity < 255
      @sprites["bg1"].opacity -= 32 rescue nil if i > 3
      @sprites["bg2"].opacity -= 32 rescue nil if i > 3
      @sprites["pager"].opacity -= 32 rescue nil if i > 3
      @sprites["pager2"].opacity -= 32 rescue nil if i > 3
      @sprites["char"].opacity -= 32 rescue nil
      @sprites["char2"].opacity -= 32 rescue nil
      @sprites["text"].opacity -= 32 rescue nil
      @sprites["up"].opacity -= 32
      @sprites["down"].opacity -= 32
      for j in 0...@book.size
        @sprites["book#{j}"].opacity -= 32 rescue nil
      end
      for j in 0...@tutorial.size
        @sprites["tutorial#{j}"].opacity -= 32 rescue nil
      end
    end
    @sprites["up"].dispose
    @sprites["down"].dispose
    @main.clear
    @text.clear rescue nil
    @text2.clear rescue nil
    @sel_two = 0
    @scene = 0
    pbDrawOutlineText(@main,0,2-178,512,384,"Library",Color.new(255,255,255),Color.new(0,0,0),1)
    pbDrawOutlineText(@main,0,142-178,512,384,"Books: " + @book.size.to_s,Color.new(255,255,255),Color.new(0,0,0),1)
    pbDrawOutlineText(@main,0,198-178,512,384,"Tutorials: " + @tutorial.size.to_s,Color.new(255,255,255),Color.new(0,0,0),1)
    12.times do |i|
      Graphics.update
      @sprites["bg0"].opacity += 32 if i < 8
      @sprites["btn0"].opacity += 32 if i > 3
      @sprites["btn1"].opacity += 32 if i > 3
      @sprites["main"].opacity += 48 if i > 5
    end
  end
  
  def pbSwitch(dir)
    if dir == :DOWN
      return if @sel_one == 1
      @sprites["btn#{@sel_one}"].src_rect.y = 0
      @sel_one += 1
      @sprites["btn#{@sel_one}"].src_rect.y = (@sprites["btn#{@sel_one}"].bitmap.height / 2).round
    else
      return if @sel_one == 0
      @sprites["btn#{@sel_one}"].src_rect.y = 0
      @sel_one -= 1
      @sprites["btn#{@sel_one}"].src_rect.y = (@sprites["btn#{@sel_one}"].bitmap.height / 2).round
    end
  end
  
  def pbMove(dir)
    pbWait(1)
    if dir == :DOWN
      return if @sel_two == @book.size - 1 && @mode == 0
      return if @sel_two == @tutorial.size - 1 && @mode == 1
      return if @book.size == 0 && @mode == 0
      return if @tutorial.size == 0 && @mode == 1
      @sprites["book#{@box}"].src_rect.y = 0 if @mode == 0
      @sprites["tutorial#{@box}"].src_rect.y = 0 if @mode == 1
      @sel_two += 1
      @box += 1
      @box = 5 if @box > 5
      @sprites["book#{@box}"].src_rect.y = (@sprites["book#{@box}"].bitmap.height / 2).round if @mode == 0
      @sprites["tutorial#{@box}"].src_rect.y = (@sprites["tutorial#{@box}"].bitmap.height / 2).round if @mode == 1
      if @box == 5
	@main.clear
	if @mode == 0
	  for i in 0...@book.size
	    break if i > 5
	    j = (i==0 ? -5 : (i==1 ? -4 : (i==2 ? -3 : (i==3 ? -2 : (i==4 ? -1 : 0)))))
	    @sprites["book#{i}"].book = @book[@sel_two+j]
	    pbDrawOutlineText(@main,11,-124+52*i,512,384,@book[@sel_two+j].name,@book[@sel_two+j].color,Color.new(0,0,0),1)
	  end
	  if @sprites["book0"].book != @book[0]
	     @sprites["up"].visible = true
	  else
	     @sprites["up"].visible = false
	  end
	  if @sprites["book5"].book != @book[@book.size - 1]
	    @sprites["down"].visible = true
	  else
	    @sprites["down"].visible = false
	  end
	  pbDrawOutlineText(@main,0,2-178,512,384,"Books",Color.new(255,255,255),Color.new(0,0,0),1)
	else
	  for i in 0...@tutorial.size
	    break if i > 5
	    j = (i==0 ? -5 : (i==1 ? -4 : (i==2 ? -3 : (i==3 ? -2 : (i==4 ? -1 : 0)))))
	    @sprites["tutorial#{i}"].book = @tutorial[@sel_two+j]
	    pbDrawOutlineText(@main,11,-124+52*i,512,384,@tutorial[@sel_two+j].name,@tutorial[@sel_two+j].color,Color.new(0,0,0),1)
	  end
	  if @sprites["tutorial0"].book != @tutorial[0]
	    @sprites["up"].visible = true
	  else
	    @sprites["up"].visible = false
	  end
	  if @sprites["tutorial5"].book != @tutorial[@tutorial.size - 1]
	    @sprites["down"].visible = true
	  else
	    @sprites["down"].visible = false
	  end
	  pbDrawOutlineText(@main,0,2-178,512,384,"Tutorials",Color.new(255,255,255),Color.new(0,0,0),1)
	end
      end
    else
      return if @sel_two == 0
      return if @book.size == 0 && @mode == 0
      return if @tutorial.size == 0 && @mode == 1
      @sprites["book#{@box}"].src_rect.y = 0 if @mode == 0
      @sprites["tutorial#{@box}"].src_rect.y = 0 if @mode == 1
      @sel_two -= 1
      @box -= 1
      @box = 0 if @box < 0
      @sprites["book#{@box}"].src_rect.y = (@sprites["book#{@box}"].bitmap.height / 2).round if @mode == 0
      @sprites["tutorial#{@box}"].src_rect.y = (@sprites["tutorial#{@box}"].bitmap.height / 2).round if @mode == 1
      if @box == 0
        @main.clear
	if @mode == 0
	  for i in 0...@book.size
	    break if i > 5
	    @sprites["book#{i}"].book = @book[@sel_two+i]
	    pbDrawOutlineText(@main,11,-124+52*i,512,384,@book[@sel_two+i].name,@book[@sel_two+i].color,Color.new(0,0,0),1)
	  end
	  if @sprites["book5"].book != @book[0]
	    @sprites["up"].visible = true
	  else
	    @sprites["up"].visible = false
	  end
	  if @sprites["book5"].book != @book[@book.size - 1]
	    @sprites["down"].visible = true
	  else
	    @sprites["down"].visible = false
	  end
	  pbDrawOutlineText(@main,0,2-178,512,384,"Books",Color.new(255,255,255),Color.new(0,0,0),1)
	else
	  for i in 0...@tutorial.size
	    break if i > 5
	    @sprites["tutorial#{i}"].book = @tutorial[@sel_two+i]
	    pbDrawOutlineText(@main,11,-124+52*i,512,384,@tutorial[@sel_two+i].name,@tutorial[@sel_two+i].color,Color.new(0,0,0),1)
	  end
	  if @sprites["tutorial0"].book != @tutorial[0]
	    @sprites["up"].visible = true
	  else
	    @sprites["up"].visible = false
	  end
	  if @sprites["tutorial5"].book != @tutorial[@tutorial.size - 1]
	    @sprites["down"].visible = true
	  else
	    @sprites["down"].visible = false
	  end
	  pbDrawOutlineText(@main,0,2-178,512,384,"Tutorials",Color.new(255,255,255),Color.new(0,0,0),1)
	end
      end
    end
  end
  
  def pbList(id)
    pbWait(1)
    @sel_two = 0
    @page = 0
    @scene = 1
    @mode = id
    @box = 0
    @sprites["up"] = IconSprite.new(0, 0, @viewport)
    @sprites["up"].setBitmap("Graphics/Pictures/bookArrow")
    @sprites["up"].zoom_x = 1.25
    @sprites["up"].zoom_y = 1.25
    @sprites["up"].x = Graphics.width / 2
    @sprites["up"].y = 36
    @sprites["up"].z = 2
    @sprites["up"].visible = false
    @sprites["down"] = IconSprite.new(0, 0, @viewport)
    @sprites["down"].setBitmap("Graphics/Pictures/bookArrow")
    @sprites["down"].zoom_x = 1.25
    @sprites["down"].zoom_y = 1.25
    @sprites["down"].x = Graphics.width / 2 + 21
    @sprites["down"].y = 360
    @sprites["down"].z = 2
    @sprites["down"].angle = 180
    @sprites["down"].visible = @mode == 0 ? @book.size > 6 : @tutorial.size > 6
    @sprites["down"].opacity = 0
    10.times do |i|
      Graphics.update
      @sprites["btn0"].opacity -= 32 if i > 1
      @sprites["btn1"].opacity -= 32 if i > 1
      @sprites["main"].opacity -= 32 if i > 1
      @sprites["bg1"].opacity -= 32 rescue nil if i > 1
      @sprites["bg2"].opacity -= 32 rescue nil if i > 1
      @sprites["pager"].opacity -= 32 rescue nil if i > 1
      @sprites["pager2"].opacity -= 32 rescue nil if i > 1
      @sprites["char"].opacity -= 32 rescue nil
      @sprites["char2"].opacity -= 32 rescue nil
      @sprites["text"].opacity -= 32 rescue nil if i > 1
      @sprites["text2"].opacity -= 32 rescue nil if i > 1
    end
    @main.clear
    @text.clear rescue nil 
    @text2.clear rescue nil
    if id == 0
      for i in 0...@book.size
	break if i > 5
        @sprites["book#{i}"] = BookSprite.new(0, 0, @viewport)
        @sprites["book#{i}"].setBitmap("Graphics/Pictures/bookBtn")
	@sprites["book#{i}"].book = @book[i]
        @sprites["book#{i}"].x = 94
        @sprites["book#{i}"].y = 42 + 52 * i
        @sprites["book#{i}"].src_rect.height = (@sprites["book#{i}"].bitmap.height / 2).round
        @sprites["book#{i}"].src_rect.y = (@sprites["book#{i}"].bitmap.height / 2).round if i == @sel_two
        @sprites["book#{i}"].opacity = 0
        pbDrawOutlineText(@main,11,-124+52*i,512,384,@book[i].name,@book[i].color,Color.new(0,0,0),1)
      end
      pbDrawOutlineText(@main,0,0,512,384,"No books found",pbColor(:WHITE),pbColor(:BLACK),1) if @book.size == 0
      pbDrawOutlineText(@main,0,2-178,512,384,"Books",Color.new(255,255,255),Color.new(0,0,0),1)
      12.times do |i|
        Graphics.update
        @sprites["main"].opacity += 32 if i < 8
        for j in 0...@book.size
	  break if j > 5
          @sprites["book#{j}"].opacity += 32 if i > 3
        end
      end
    elsif id == 1
      for i in 0...@tutorial.size
	break if i > 5
        @sprites["tutorial#{i}"] = BookSprite.new(0, 0, @viewport)
        @sprites["tutorial#{i}"].setBitmap("Graphics/Pictures/bookBtn")
        @sprites["tutorial#{i}"].x = 94
        @sprites["tutorial#{i}"].y = 42 + 52 * i
        @sprites["tutorial#{i}"].src_rect.height = (@sprites["tutorial#{i}"].bitmap.height / 2).round
        @sprites["tutorial#{i}"].src_rect.y = (@sprites["tutorial#{i}"].bitmap.height / 2).round if i == @sel_two
        @sprites["tutorial#{i}"].opacity = 0
        pbDrawOutlineText(@main,11,-124+52*i,512,384,@tutorial[i].name,@tutorial[i].color,Color.new(0,0,0),1)
      end
      pbDrawOutlineText(@main,0,0,512,384,"No tutorials found",pbColor(:WHITE),pbColor(:BLACK),1) if @tutorial.size == 0
      pbDrawOutlineText(@main,0,2-178,512,384,"No tutorials found",Color.new(255,255,255),Color.new(0,0,0),1)
      12.times do |i|
        Graphics.update
        @sprites["main"].opacity += 32 if i < 8
	@sprites["down"].opacity += 32 if i > 3
        for j in 0...@tutorial.size
	  break if j > 5
          @sprites["tutorial#{j}"].opacity += 32 if i > 3
        end
      end
    end
  end
  
  def pbEnd
    12.times do |i|
      Graphics.update
      @sprites["bg0"].opacity -= 32 if i > 3
      @sprites["btn0"].opacity -= 32
      @sprites["btn1"].opacity -= 32
      @sprites["main"].opacity -= 32
      @sprites["char"].opacity -= 40 rescue nil
      @sprites["char2"].opacity -= 40 rescue nil
    end
  end
end