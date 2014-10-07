----------------------------------------------------------------------------------
--
-- scenetemplate.lua
--
----------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

----------------------------------------------------------------------------------
-- 
--	NOTE:
--	
--	Code outside of listener functions (below) will only be executed once,
--	unless storyboard.removeScene() is called.
-- 
---------------------------------------------------------------------------------

---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------


---------------------------------------------------------------------------------
-- 
-- Define some variables 
-- 
---------------------------------------------------------------------------------

local widget = require( "widget" )
local listView

-- This table holds all of the data that describes the table view content. 
local listData = {
	{title="Alien 1", subtext="Blue with antenae", image="Alien_32_1.png", rating=3},
	{title="Alien 2", subtext="Pink with leaves", image="Alien_32_2.png", rating=4},
	{title="Alien 3", subtext="Green with eye stalks", image="Alien_32_3.png", rating=3},
	{title="Alien 4", subtext="Red with tongue", image="Alien_32_4.png", rating=3},
	{title="Alien 5", subtext="Orange shaped like a cookie", image="Alien_32_5.png", rating=3},
	{title="Alien 6", subtext="Teal, with teeth, and a hangover", image="Alien_32_6.png", rating=3}
}



-- onRowRender
----------------------------------------------------------------------------------
-- This function draws each table view cell. The example has two text objects, 
-- an image, and a disclosure icon. You'll need to create each element, add it
-- it to the row group with :insert(), and position it within the cell. 
-- The height of each cell is set when the cell is created, see insertRow() below.
-- I've set the height of each cell 48 for this example. 

local function onRowRender( event )
	local row = event.row
	local index = row.index
	local rowData = listData[index]
	
	-- Cell Title
	local titleText = display.newText( rowData.title, 0, 0, native.systemFontBold, 16 )
	titleText:setFillColor( 80/255, 80/255, 80/255 )
	titleText.anchorX = 0
	titleText.anchorY = 0
	row:insert( titleText )
	titleText.x = 60
	titleText.y = 4
	
	-- Cell subtext 
	local subText = display.newText( rowData.subtext, 0, 0, native.systemFont, 12 )
	subText:setFillColor( 120/255, 120/255, 120/255 )
	subText.anchorX = 0
	subText.anchorY = 0
	row:insert( subText )
	subText.x = 60
	subText.y = 26
	
	-- Cell image
	-- Here I get the name of the image from the listData and add the folder name 
	-- to get a path to the image. If all all of the images are the same size you 
	-- can set the size here. 
	local cellImage = display.newImageRect( "images/"..rowData.image, 32, 32 )
	row:insert( cellImage )
	cellImage.x = 30
	cellImage.y = 24
	
	-- Disclosure icon
	local arrow = display.newImageRect( "images/arrow.png", 10, 27 )
	row:insert( arrow )
	arrow.x = 300
	arrow.y = 24
end 







----------------------------------------------------------------------------------
-- 
-- Storyboard handlers 
-- 
----------------------------------------------------------------------------------


-- The all important create scene handler. Use this to create the table view 
----------------------------------------------------------------------------------
-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view

	-- Make a new tableView object. Set options describing the overall appearance of 
	-- the tableview. 
	listView = widget.newTableView( {
		left=0,
		top=0,
		topPadding=20,	-- Adds padding to the top of the table view. 
		width=display.contentWidth,
		height=display.contentHeight,
		onRowRender=onRowRender -- Calls the function above which draws each cell. 
	} )
	
	-- Add some rows to the tableView. Here we create a cell for each item in 
	-- the data table above. 
	for i = 1, #listData do 
		listView:insertRow( {
			rowHeight=48
		} )
	end
end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	
end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view
	
end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	local group = self.view
	
end


---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

---------------------------------------------------------------------------------

return scene