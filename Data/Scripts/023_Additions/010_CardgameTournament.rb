################################################################################
#   Card Game Tournament by Tastyredtomato
#
#
#------------------------------------------------------------------------------
#How to use:
#
# - to play matches use pbCardTournamentDuelM(x,y) or pbCardTournamentDuelF(x,y)
#
# - when finishing a tournament or checking the daily prize:
#        use the method pbGetPrize to get the prize id
#
# - when playing a match or checking the daily rules:
#        use the method pbGetRuleOne and pbGetRuleTwo to get the rules
#
# - you can use the namemethods pbMaleNamePool and pbFemaleNamePool
#        to get a random name for a card player
#
# - In the two methods below (pbPrizePool and pbRulePool), you can
#        make the array of prizes and rules you want to use
#  note! if you want you can make multiple pools, just copy/paste the method 
#        and rename it
#
################################################################################

#CONFIGURATION

#this array is dynamic, you can add or remove prizes as fit, duplicate prizes will increase odds
#the data must match the numbers in the items PBS file
def pbPrizePool
  prizes = [
  558,
  535,
  221,
  113,
  71,
  48,
  48,
  48,
  46,
  45,
  28,
  29,
  30,
  20,
  31, 
  32, 
  558, 
  558, 
  558, 
  558, 
  558, 
  558, 
  77, 
  568, 
  568, 
  558, 
  558, 
  558, 
  558, 
  558, 
  558, 
  558, 
  558,
  558,
  558,
  558
  ]
  return prizes
end

#this array is dynamic, you can add or remove rules as fit, do not duplicate rules except the empty ones ""
#should you add or remove game rules to triple triad, you can do so here
def pbRulePool
  rules = [
  "samewins",
  "openhand",
  "wrap",
  "elements",
  "randomhand",
  "countunplayed",
  "direct",
  "winall",
  " ",
  " ",
  " ",
  " ",
  " ",
  " ",
  " ",
  " ",
  " ",
  " "
  ]
  
  return rules
end

#this array is dynamic, you can add or remove names as fit, duplicate names will appear more often
def pbMaleNamePool
  names =[
  "Jack",
  "Jonas",
  "Sam",
  "Maverick",
  "Henry",
  "Jules",
  "Edgar",
  "Thomas",
  "Oliver",
  "Liam",
  "Leroy",
  "Tony"
  ]
  i = rand(names.length())
  return names[i]
end

#this array is dynamic, you can add or remove names as fit, duplicate names will appear more often
def pbFemaleNamePool
  names =[
  "Ruby",
  "Alexa",
  "Rose",
  "Sam",
  "Camille",
  "Maria",
  "Elisabeth",
  "July",
  "Amelia",
  "Olivia",
  "Abby",
  "Nora"
  ]
  i = rand(names.length())
  return names[i]
end

#-----------------------------------------------------do not edit below here D:<

def pbCardTournamentDuelM(x,y) #use these instead of the regular pbtriadduel, x and y being the difficulty modifiers
  ret = pbTriadDuel(pbMaleNamePool,x,y,[pbGetRuleOne(pbGetMatchToken,pbRulePool),pbGetRuleTwo(pbGetMatchToken,pbRulePool)],nil,nil)
  return ret
end
  
def pbCardTournamentDuelF(x,y) #use these instead of the regular pbtriadduel, x and y being the difficulty modifiers
  ret = pbTriadDuel(pbFemaleNamePool,x,y,[pbGetRuleOne(pbGetMatchToken,pbRulePool),pbGetRuleTwo(pbGetMatchToken,pbRulePool)],nil,nil)
  return ret
end

def pbGetPrize(var,prizes) #use pbGetMatchToken for the var, pbprizepool for the prizes array
  i = var % prizes.length()
  return prizes[i]
end

def pbGetRuleOne(var,rules) #use pbGetMatchToken for the var, pbrulepool for the rules array
   i = var % rules.length()
   return rules[i]
 end
 
 def pbGetRuleOneVal(var,rules) #used as a dependency to calculate rule 2
   i = var % rules.length()
   return i
end
 
def pbGetRuleTwo(var,rules) #use pbGetMatchToken for the var, pbprulepool for the rules array
   i = (pbGetRuleOneVal(var,rules) + pbGetwdaynumber) % rules.length()
   strR = rules[i]
   if strR = pbGetRuleOne(var,rules)
     return " "
   else
     return rules[i]
   end
end
 
#this method returns the day of the month (from 0 to 30)
def pbGetdaynumber
  time = pbGetTimeNow if !time
  return time.day
end

#this method returns the day of the weekday (from 0 being sunday to 6 being saturday)
def pbGetwdaynumber
  time = pbGetTimeNow if !time
  return time.wday
end

#this method generates a match token which will determine the ruleset and prizes
#the lowest value it can return is 0, the highest 180
def pbGetMatchToken
  m = pbGetdaynumber
  d = pbGetwdaynumber
  t = m*d
  return t
end

