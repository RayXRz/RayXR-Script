RemoveCallbacks()
Sleep(2000)

function OnTextOverlay(text)
  var = {}
  var[0] = "OnTextOverlay"
  var[1] = text
  var.netid = -1
  SendVarlist(var)
end

function OnConsoleMessage(text)
  var = {}
  var[0] = "OnConsoleMessage"
  var[1] = text
  var.netid = -1
  SendVarlist(var)
end

function hook(varlist, packet)
	if varlist[0]:find("OnDialogRequest") then
		return true
	end
end



px = GetLocal().pos_x//32
py = GetLocal().pos_y//32

function proxy_commands()
varlist = {}
varlist[0] = "OnDialogRequest"
varlist[1] = [[set_default_color|`o
add_label_with_icon|big|`3Proxy Command``|left|3102|
add_spacer|small|
add_textbox|`9Proxy By : `!RayXR|left|
add_spacer|small|
add_spacer|small|
add_label_with_icon|small|`3Proxy Commands``|left|5772|
add_spacer|small|
add_smalltext|`9Command : `#/wd `5To Drop World Lock|left|
add_smalltext|`9Command : `#/dd `5To Drop Diamond Lock|left|
add_smalltext|`9Command : `#/st `5To Set Telephone|left|
add_smalltext|`9Command : `#/cbgl `5To Change DL To BGL|left|
add_smalltext|`9Command : `#/spin reme `5To Set Spin Mode To Reme|left| 
add_smalltext|`9Command : `#/spin all `5To Set Spin Mode To All|left|
add_smalltext|`9Command : `#/spin checker `5To Set Spin Mode To Checker|left|
add_smalltext|`9Command : `#/sv `5To Set Vending Machine Pos|left|
add_smalltext|`9Command : `#/setbuy `5To Set How Many To Buy For /b or /fv|left|
add_smalltext|`9Command : `#/buyv or /b `5To Teleport And Buy To The Vend|left|
add_smalltext|`9Command : `#/fv or /fastvend `5To Toggle Fast Buy In Vend|left|
add_smalltext|`9Command : `#/autosurg `5To Toggle Auto Surgery|left|
add_spacer|small|
add_quick_exit|
end_dialog|proxy_main_cmd|Okay|
]]
varlist.netid = -1

SendVarlist(varlist)
end
proxy_commands()

function proxy(type, packet)
  if packet == ("action|input\n|text|/proxy") then
      proxy_commands()
      return true
  end
end

AddCallback("proxy_commandsx","OnPacket", proxy)



function wd(type, packet)
    if packet:find("action|input\n|text|/wd") then
          amountwl = packet:gsub("action|input\n|text|/wd", "")
          SendPacket(2, "action|dialog_return\ndialog_name|drop\nitem_drop|242|\nitem_count|"..amountwl)
          OnConsoleMessage("`bDropped `4"..amountwl.." `4WLS")
          return true
    end
end
AddCallback("wldrop","OnPacket", wd)


function dd(type, packet)
    if packet:find("action|input\n|text|/dd") then
          amountdl = packet:gsub("action|input\n|text|/dd", "")
          SendPacket(2, "action|dialog_return\ndialog_name|drop\nitem_drop|1796|\nitem_count|"..amountdl)
          OnConsoleMessage("`bDropped `4"..amountdl.." `4DLS")
          return true
    end
end
AddCallback("dldrop","OnPacket", dd)

Wlbalance = GetItemCount(242)
Dlbalance = GetItemCount(1796)
Bglbalance = GetItemCount(7188)


function balance(type, packet)
    if packet:find("action|input\n|text|/bal") then
        OnConsoleMessage("`bWorld Lock `9= `4"..Wlbalance)
        OnConsoleMessage("`bDiamond Lock `9= `4"..Dlbalance)
        OnConsoleMessage("`bBlue Gem Lock `9= `4"..Bglbalance)
          return true
    end
end
AddCallback("balance","OnPacket", balance)


function string.removeColors(varlist)
    return varlist:gsub("`.", "")
end

function qq_function(num)
    return num % 10
end

function reme_function(num)
    local sum = 0
    while num > 0 do
      sum = sum + (num % 10)
      num = math.floor(num / 10)
    end
    return sum
end

function reme_spin(type, packet)
    if packet == ("action|input\n|text|/spin reme") then
        OnConsoleMessage("`9Spin mode set to `3REME")
function Spin_checker(varlist)
    if varlist[0] == "OnTalkBubble" and varlist[3] ~= -1 and varlist[2]:find("spun the wheel and got") then
      text = ""
      if varlist[2]:find("CP:") then
        start, final = string.find(varlist[2], "=")
        text = "`0[ `4FAKE `0] " .. string.sub(varlist[2], final + 1)
      else
        x = varlist[2]:removeColors()
        x2 = x:match("spun the wheel and got (%d+)")
        x2 = tonumber(x2)
        qq_mode = qq_function(x2)
        reme_mode2 = reme_function(x2)
        reme_mode = qq_function(reme_mode2)
        var = {}
        var[0] = "OnTalkBubble"
        var[1] = varlist[1]
        var[2] = varlist[2].." `9REME : `3"..reme_mode
        var[3] = -1
        var.netid = -1
        SendVarlist(var)
        return true
      end
      SendVarlist({
        [0] = "OnTalkBubble",
        [1] = varlist[1],
        [2] = text,
        [3] = -1,
        netid = -1,
      })
      return true
    end
  end
AddCallback("Spin_checker", "OnVarlist", Spin_checker)
return true
end
end

AddCallback("reme_spin","OnPacket", reme_spin)

function Spin_checker(varlist)
    if varlist[0] == "OnTalkBubble" and varlist[3] ~= -1 and varlist[2]:find("spun the wheel and got") then
      text = ""
      if varlist[2]:find("CP:") then
        start, final = string.find(varlist[2], "=")
        text = "`0[ `4FAKE `0] " .. string.sub(varlist[2], final + 1)
      else
        x = varlist[2]:removeColors()
        x2 = x:match("spun the wheel and got (%d+)")
        x2 = tonumber(x2)
        qq_mode = qq_function(x2)
        reme_mode2 = reme_function(x2)
        reme_mode = qq_function(reme_mode2)
        var = {}
        var[0] = "OnTalkBubble"
        var[1] = varlist[1]
        var[2] = "`0[ `2REAL `0] "..varlist[2]
        var[3] = -1
        var.netid = -1
        SendVarlist(var)
        return true
      end
      SendVarlist({
        [0] = "OnTalkBubble",
        [1] = varlist[1],
        [2] = text,
        [3] = -1,
        netid = -1,
      })
      return true
    end
  end
AddCallback("Spin_checker", "OnVarlist", Spin_checker)

function check_spin(type, packet)
    if packet == ("action|input\n|text|/spin check") then
        OnConsoleMessage("`0[ `3Mandq#3038 `0] `9Spin mode set to `3Checker")
function Spin_checker(varlist)
    if varlist[0] == "OnTalkBubble" and varlist[3] ~= -1 and varlist[2]:find("spun the wheel and got") then
      text = ""
      if varlist[2]:find("CP:") then
        start, final = string.find(varlist[2], "=")
        text = "`0[ `4FAKE `0] " .. string.sub(varlist[2], final + 1)
      else
        x = varlist[2]:removeColors()
        x2 = x:match("spun the wheel and got (%d+)")
        x2 = tonumber(x2)
        qq_mode = qq_function(x2)
        reme_mode2 = reme_function(x2)
        reme_mode = qq_function(reme_mode2)
        var = {}
        var[0] = "OnTalkBubble"
        var[1] = varlist[1]
        var[2] = "`0[ `2REAL `0] "..varlist[2]
        var[3] = -1
        var.netid = -1
        SendVarlist(var)
        return true
      end
      SendVarlist({
        [0] = "OnTalkBubble",
        [1] = varlist[1],
        [2] = text,
        [3] = -1,
        netid = -1,
      })
      return true
    end
  end
AddCallback("Spin_checker", "OnVarlist", Spin_checker)
return true
end
end

AddCallback("check_spin","OnPacket", check_spin)


function all_spin(type, packet)
    if packet == ("action|input\n|text|/spin all") then
        OnConsoleMessage("`0[ `3Mandq#3038 `0] `9Spin mode set to `3QQ & REME")
function Spin_checker(varlist)
    if varlist[0] == "OnTalkBubble" and varlist[3] ~= -1 and varlist[2]:find("spun the wheel and got") then
      text = ""
      if varlist[2]:find("CP:") then
        start, final = string.find(varlist[2], "=")
        text = "`0[ `4FAKE `0] " .. string.sub(varlist[2], final + 1)
      else
        x = varlist[2]:removeColors()
        x2 = x:match("spun the wheel and got (%d+)")
        x2 = tonumber(x2)
        qq_mode = qq_function(x2)
        reme_mode2 = reme_function(x2)
        reme_mode = qq_function(reme_mode2)
        var = {}
        var[0] = "OnTalkBubble"
        var[1] = varlist[1]
        var[2] = varlist[2].." `9CSN : `3"..x2.." `0x `9QEME : `3"..qq_mode.." `0x `9REME : `3"..reme_mode
        var[3] = -1
        var.netid = -1
        SendVarlist(var)
        OnConsoleMessage(varlist[2].." `9CSN : `3"..x2.." `0x `9QEME : `3"..qq_mode.." `0x `9REME : `3"..reme_mode)
        return true
      end
      SendVarlist({
        [0] = "OnTalkBubble",
        [1] = varlist[1],
        [2] = text,
        [3] = -1,
        netid = -1,
      })
      return true
    end
  end
AddCallback("Spin_checker", "OnVarlist", Spin_checker)
return true
end
end

AddCallback("all_spin","OnPacket", all_spin)

x_telephone = -1

function tp_telephone(type, packet)
  if packet == ("action|input\n|text|/cbgl") then
      if x_telephone == -1 then
          OnTextOverlay("`4Pos Not Set")
      else
      SendPacket(2, "action|dialog_return\ndialog_name|telephone\nnum|53785|\nx|"..x_telephone.."|\ny|"..y_telephone.."|\nbuttonClicked|bglconvert")
      end

  return true
  end
end
  
AddCallback("cbgl","OnPacket", tp_telephone)

function post(type, packet)
  if packet == ("action|input\n|text|/st") then
      x_telephone = math.floor(GetLocal().pos_x / 32)
      y_telephone = math.floor(GetLocal().pos_y / 32)
      OnConsoleMessage("`9pos Telephone has been set")
      local var = {}
      var[0] = "OnParticleEffect"
      var[1] = 3
      var[2] = { GetLocal().pos_x + 10, GetLocal().pos_y + 15}
      var[3] = 0
      var[4] = 0
      var.netid = -1
      SendVarlist(var)
  return true
  end
end

AddCallback("post","OnPacket", post)


amountbuy = 1
function setbuy(type, packet)
  if packet:find("action|input\n|text|/setbuy") then
        amountbuy = packet:gsub("action|input\n|text|/setbuy", "")
        OnConsoleMessage("`bBuy Amount Set to"..amountbuy)
        return true
  end
end
AddCallback("setbuy","OnPacket", setbuy)


x_vend = -1

function buy(type, packet)
if packet == ("action|input\n|text|/b") or packet == ("action|input\n|text|/buyv") then
    if x_vend == -1 then
        OnTextOverlay("`4Pos Not Set")
    else
      FindPath(x_vend,y_vend)
      SendPacket(2, "action|dialog_return\ndialog_name|vend_buyconfirm\nx|"..x_vend.."|\ny|"..y_vend.."|\nbuyamount|"..amountbuy.."|")
    end

return true
end
end

AddCallback("buy","OnPacket", buy)

function buypos(type, packet)
if packet == ("action|input\n|text|/sv") then
    x_vend = math.floor(GetLocal().pos_x / 32)
    y_vend = math.floor(GetLocal().pos_y / 32)
    OnConsoleMessage("`9Vend pos has been set")
    local var = {}
    var[0] = "OnParticleEffect"
    var[1] = 3
    var[2] = { GetLocal().pos_x + 10, GetLocal().pos_y + 15}
    var[3] = 0
    var[4] = 0
    var.netid = -1
    SendVarlist(var)
return true
end
end

AddCallback("buypos","OnPacket", buypos)

function fastsvend(var)
  if var[0] == "OnDialogRequest" then
if var[1]:find("Vending Machine") or var[1]:find("DigiVend Machine") then
  xstock = var[1]:match("|x|(%d+)")
  ystock = var[1]:match("|y|(%d+)")
  SendPacket(2, "action|dialog_return\ndialog_name|vend_buyconfirm\nx|"..xstock.."|\ny|"..ystock.."|\nbuyamount|"..amountbuy.."|")
  return true
    end
  end
end



  fastvend = false
  function fastvendcmd(type, packet)
    if packet == ("action|input\n|text|/fv") or packet == ("action|input\n|text|/fastvend") then
      if fastvend == false then
        fastvend = true
        OnConsoleMessage("`#Fast vend Mode `5ON")
        AddCallback("FastVend", "OnVarlist", fastsvend)
      else
        fastvend = false
        OnConsoleMessage("`#Fast vend Mode `5OFF")
        RemoveCallback("FastVend")
    return true
    end
  end
    end
    AddCallback("fastvendcmd","OnPacket", fastvendcmd)


    function autosurgwrench(type, packet)
      if packet:find("action|wrench\n|netid|(%d+)") then
          id = packet:match("action|wrench\n|netid|(%d+)")
          SendPacket(2,"action|dialog_return\ndialog_name|popup\nnetID|"..id.."|\nbuttonClicked|surgery")
      return true
      end
    end
  
  surgerym = false
  function autosurg(type, packet)
      if packet:find("action|input\n|text|/autosurg") then
          if surgerym == false then
              surgerym = true
              AddCallback("autosurgwrench","OnPacket", autosurgwrench)
              OnTextOverlay("`2Surgery Mode On")
              AddCallback("Surg", "OnVarlist", surg)
          else
              surgerym = false
              RemoveCallback("autosurgwrench")
              OnTextOverlay("`4Surgery Mode Off")
              RemoveCallback("Surg")
            return true
      end
  end
  end
  AddCallback("autosurg","OnPacket", autosurg)
  
  
  
  
  
  function malpractice(dt , packet)
  if dt[0] == "OnConsoleMessage" and dt[1]:find("You are not allowed to perform surgery") then
  SendPacket(2, "action|input\n|text|/modage 999")
  OnTextOverlay("`4FAILED")
      return true
      end
      return false
      end
  AddCallback("malpractice" , "OnVarlist" , malpractice)
  
  function uk(dt , packet)
      if dt[0] == "OnConsoleMessage" and dt[1]:find("Unknown command.") then
          return true
          end
          end
      AddCallback("uk" , "OnVarlist" , uk)
  
      function surg(var)
      if var[0] == "OnDialogRequest" and var[1]:find("`4Awake!") then
          SendPacket(2, "action|dialog_return\ndialog_name|surgery\nbuttonClicked|command_2\n")
          OnConsoleMessage("`#Using `5Anesthetic")
          Sleep(50)
          return true
      elseif var[0]:find("OnDialogRequest") and var[1]:find("`6It is becoming hard to see your work.") then 
          SendPacket(2, "action|dialog_return\ndialog_name|surgery\nbuttonClicked|command_0\n")
          OnConsoleMessage("`#Using `5Sponge")
          Sleep(50)
          return true
      elseif var[0]:find("OnDialogRequest") and var[1]:find("`4You can't see what you are doing!(.+)") then 
          SendPacket(2, "action|dialog_return\ndialog_name|surgery\nbuttonClicked|command_0\n")
          OnConsoleMessage("`#Using `5Sponge")
          Sleep(50)
          return true
      elseif var[0]:find("OnDialogRequest") and var[1]:find("Patient's fever is `3slowly rising.") then 
          SendPacket(2, "action|dialog_return\ndialog_name|surgery\nbuttonClicked|command_4\n")
          OnConsoleMessage("`#Using `5Antibiotic")
          Sleep(50)
          return true
      elseif var[0]:find("OnDialogRequest") and var[1]:find("Patient's fever is `6climbing.") then 
          SendPacket(2, "action|dialog_return\ndialog_name|surgery\nbuttonClicked|command_4\n")
          OnConsoleMessage("`#Using `5Antibiotic")
          Sleep(50)
          return true
      elseif var[0]:find("OnDialogRequest") and var[1]:find("Patient's fever is `4climbing rapidly!.") then 
          SendPacket(2, "action|dialog_return\ndialog_name|surgery\nbuttonClicked|command_4\n")
          OnConsoleMessage("`#Using `5Antibiotic")
          Sleep(50)
          return true
      elseif var[0]:find("OnDialogRequest") and var[1]:find("Operation site: `3Not sanitized") then 
          SendPacket(2, "action|dialog_return\ndialog_name|surgery\nbuttonClicked|command_3\n")
          OnConsoleMessage("`#Using `5Antiseptic")
          Sleep(50)
          return true
      elseif var[0]:find("OnDialogRequest") and var[1]:find("Operation site: `6Unclean") then 
          SendPacket(2, "action|dialog_return\ndialog_name|surgery\nbuttonClicked|command_3\n")
          OnConsoleMessage("`#Using `5Antiseptic")
          Sleep(50)
          return true
      elseif var[0]:find("OnDialogRequest") and var[1]:find("Operation site: `4Unsanitary") then 
          SendPacket(2, "action|dialog_return\ndialog_name|surgery\nbuttonClicked|command_3\n")
          OnConsoleMessage("`#Using `5Antiseptic")
          Sleep(50)
          return true
      elseif var[0]:find("OnDialogRequest") and var[1]:find("Patient is `6losing blood!") then 
          SendPacket(2, "action|dialog_return\ndialog_name|surgery\nbuttonClicked|command_6\n")
          OnConsoleMessage("`#Using `5Stitchess")
          Sleep(50)
          return true
      elseif var[0]:find("OnDialogRequest") and var[1]:find("Patient is losing blood `3slowly") then 
          SendPacket(2, "action|dialog_return\ndialog_name|surgery\nbuttonClicked|command_6\n")
          OnConsoleMessage("`#Using `5Stitchess")
          Sleep(50)
          return true
      elseif var[0]:find("OnDialogRequest") and var[1]:find("Patient is losing blood `4very quickly!") then 
          SendPacket(2, "action|dialog_return\ndialog_name|surgery\nbuttonClicked|command_6\n")
          OnConsoleMessage("`#Using `5Stitchess")
          Sleep(50)
          return true
      elseif var[0]:find("OnDialogRequest") and var[1]:find("`4You can't see what you are doing!") then
          SendPacket(2, "action|dialog_return\ndialog_name|surgery\nbuttonClicked|command_0\n")
          OnConsoleMessage("`#Using `5Sponge")
          Sleep(50)
      return true
      elseif var[0]:find("OnDialogRequest") and var[1]:find("Patient's fever is `3slowly rising.") then
          SendPacket(2, "action|dialog_return\ndialog_name|surgery\nbuttonClicked|command_4\n")
          OnConsoleMessage("`#Using `5AntiBiotic")
          Sleep(50)
          return true
      elseif var[0]:find("OnDialogRequest") and var[1]:find("1296") and var[1]:find("Incisions: `30") then
          SendPacket(2, "action|dialog_return\ndialog_name|surgery\nbuttonClicked|command_7\n")
          OnConsoleMessage("`#Using `5Fix It")
          Sleep(50)
          return true
      elseif var[0]:find("OnDialogRequest") and var[1]:find("1296") and var[1]:find("Incisions: `31") then
          SendPacket(2, "action|dialog_return\ndialog_name|surgery\nbuttonClicked|command_7\n")
          OnConsoleMessage("`#Using `5Fix It")
          Sleep(50)
          return true
      elseif var[0]:find("OnDialogRequest") and var[1]:find("1296") and var[1]:find("Incisions: `32") then
          SendPacket(2, "action|dialog_return\ndialog_name|surgery\nbuttonClicked|command_7\n")
          OnConsoleMessage("`#Using `5Fix It")
          Sleep(50)
          return true
      elseif var[0]:find("OnDialogRequest") and var[1]:find("1296") and var[1]:find("Incisions: `33") then
          SendPacket(2, "action|dialog_return\ndialog_name|surgery\nbuttonClicked|command_7\n")
          OnConsoleMessage("`#Using `5Fix It")
          Sleep(50)
          return true
      elseif var[0]:find("OnDialogRequest") and var[1]:find("1296") and var[1]:find("Incisions: `44") then
          SendPacket(2, "action|dialog_return\ndialog_name|surgery\nbuttonClicked|command_7\n")
          OnConsoleMessage("`#Using `5Fix It")
          Sleep(50)
          return true
      elseif var[0]:find("OnDialogRequest") and var[1]:find("1296") and var[1]:find("Incisions: `45") then
          SendPacket(2, "action|dialog_return\ndialog_name|surgery\nbuttonClicked|command_7\n")
          OnConsoleMessage("`#Using `5Fix It")
          Sleep(50)
          return true
      elseif var[0]:find("OnDialogRequest") and var[1]:find("1260") then
          SendPacket(2, "action|dialog_return\ndialog_name|surgery\nbuttonClicked|command_1\n")
          OnConsoleMessage("`#Using `5Scalpel")
                    Sleep(50)
          return true
      end
      end  