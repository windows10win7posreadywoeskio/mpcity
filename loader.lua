local loaderurl = "https://raw.githubusercontent.com/synolope/mpcity/main/loader.lua?token=GHSAT0AAAAAABTEMCA5SW6ONH2QFWSEKJXMYSHUCQQ"
local scripturl = "https://raw.githubusercontent.com/synolope/mpcity/main/script.lua?token=GHSAT0AAAAAABTEMCA54XOVJHPRZVQ2YEKSYSHUAQA"
loadstring(game:HttpGet(scripturl,true))()

syn.queue_on_teleport([[
    wait(3)
    loadstring(game:HttpGet("]] .. loaderurl .. [[",true))()
]])