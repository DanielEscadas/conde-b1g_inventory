fx_version 'adamant'

game 'gta5'

description "conde-b1g_inventory"

version "1.0"

ui_page "html/ui.html"

client_scripts {
  "@es_extended/locale.lua",
  "client/main.lua",
  "client/shop.lua",
  "client/weapons.lua",
  "common/weapons.lua",
  "locales/en.lua",
  "config.lua"
}

server_scripts {
  '@mysql-async/lib/MySQL.lua',
  "@es_extended/locale.lua",
  "server/main.lua",
  "common/weapons.lua",
  "locales/en.lua",
  "config.lua"
}

files {
  "html/ui.html",
  "html/css/ui.css",
  "html/css/jquery-ui.css",
  "html/js/inventory.js",
  "html/js/config.js",
  -- JS LOCALES
  "html/locales/cs.js",
  "html/locales/en.js",
  "html/locales/fr.js",
  -- IMAGES
  "html/img/bullet.png",
  "html/img/*.svg",
  -- ITEMSSSSSSSSSSSSSSSSS PICS
  "html/img/bread.png"
}
