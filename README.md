# conde-b1g_inventory 1.0.0

Inventory HUD for ESX based on TSRAK esx_inventoryhud made by me and B1G https://github.com/CarlosVergikosk.

Most of the code of the shops was taken from SUKU's suku shops for esx_inventoryhud, although some features were added, like ilegal shop, police shop, price easily changeable on the config, and some other spicy stuff :)

The weapons as items part is made like in disc_inventoryhud, and for that reason it uses disc_ammo in which you can easily remove the disc_base dependency if you want!

This resource should work on ESX 1.2, but I use a version before the 1.2 and after the weight update!

You can get it to work with most of esx_inventoryhud plugins, like trunk, property etc.. Check the js file most things come already pre configured!

Most of the notifications are in Portuguese, so if any kind sould want to translate them, that would be apreciated!

I may give some support, but won't 100% guarantee.

That's pretty much it, this is like the ultimate inventory hud that you can have on your ESX server without breaking or leaving your server unplayable, I'll list the features down below.


## Requirements
* [es_extended]
* [mythic_notify]
* [disc_ammo](https://github.com/DiscworldZA/gta-resources/tree/master/disc-ammo)



## Features
- Drag and drop
- Using items
- Dropping items
- Giving items
- Cash included
- Accounts support (bank, black money, ...)
- Weight Supported
- Weapons as items
- 5 Usable Fast Items hotbar:  1, 2 ,3 ,4 ,5 keys
- Blocked Weapon Wheel
- Inventory items notification (anytime you receive or lose an item, check installation for more info)
- Fast items Hotbar , ALT is the default key.
- Animations with props, when you give an item. Check the config to add more props to each item!
- Integrated status hud, so you can have a clean hud while you play!
- Easy shortcuts to use items, double click uses the item and closes the inventory, right click puts the item on fast item hotbar or in the second inventory.
- Steal the body of a dead or handcuffed player!
- Optimized
- Some other stuff, I'll probably remember later :)



## Screens
<img src="https://cdn.discordapp.com/attachments/696693383782989824/741460412863610960/unknown.png">
<img src="https://cdn.discordapp.com/attachments/696693383782989824/741460894084497438/unknown.png">
<img src="https://cdn.discordapp.com/attachments/696693383782989824/741460932835672096/unknown.png">
<img src="https://cdn.discordapp.com/attachments/696693383782989824/741461007020589066/unknown.png">


## Commands
* **/steal** - Steals nearby player's inventory
* **/closeinventory** - Closes the inventory if needed

## Installation

- This should be pretty much drag and drop, change the essentialmode on the sql file to whatever is your database name, and run it.
- To add the notifications, just trigger this event on your es_extended classes/player functions. Ex: addInventoryItem, removeInventoryItem, addMoney, removeMoney:

			TriggerClientEvent('conde-inventoryhud:notification', (playerid), (item name), (item label), (count) , (if you add the item then set thist to false, if you remove set this to true))
- To make the status to work just change the events on line 250 client/main of the inventory, to your basic needs or stress events.






