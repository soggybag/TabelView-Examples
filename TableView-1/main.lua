-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here


local widget = require( "widget" )

local ROW_COLOR 		= {
	default={222/255, 0/255,222/255, 1.0}, 
	over={222/255, 100/255,222/255, 1.0}
}
local ROW_CATEGORY_COLOR= {
	default={100/255,0/255,100/255, 1.0}, 
	over={100/255,0/255,100/255, 1.0}
}
local LINE_COLOR 		= {255/255, 0/255, 0/255, 1.0}
local BACKGROUND_COLOR 	= {222/255,100/255,222/255, 1.0}

local ROW_CATEGORY_HEIGHT = 28

local LABEL_FONT_SIZE = 20
local LABEL_FONT = native.systemFont
local LABEL_COLOR = {100/255,100/255,100/255, 1.0 }
local ROW_LABEL_COLOR = {200/255,200/255,200/255, 1.0 }

local SUB_FONT_SIZE = 14
local SUB_FONT = native.systemFont
local SUB_COLOR = {100/255,100/255,100/255, 1.0 }


local data_array = { 
	{label="Thing A", sub_text="some more text"},
	{label="Thing B", sub_text="some more text"},
	{label="Thing Three", sub_text="some more text"},
	{label="Thing more", sub_text="some more text"},
	{label="A"},
	{label="Another Thing", sub_text="some more text"},
	{label="And, one more Thing", sub_text="some more text"},
	{label="Thing", sub_text="some more text"},
	{label="Thing", sub_text="some more text"},
	{label="B"},
	{label="Thing", sub_text="some more text"},
	{label="Thing", sub_text="some more text"},
	{label="Thing", sub_text="some more text"},
	{label="Thing", sub_text="some more text"}, 
}


-- onEvent listener for the tableView
local function onRowTouch( event )
    local row = event.target
    local index = row.index
    
	if event.phase == "press" then
		if not row.isCategory then 
			-- row.alpha = 0.5 
		end

	elseif event.phase == "swipeLeft" then
		print( "Swiped left." )

	elseif event.phase == "swipeRight" then
		print( "Swiped right." )

	elseif event.phase == "release" then
		if not row.isCategory then
			-- reRender property tells row to refresh if still onScreen when content moves
			row.reRender = true
			print( "You touched row #" .. index )
		end
	end

	return true
end
 
local function onRowRender( event )
	-- Get reference to the row group
    local row = event.row
    local index = row.index
	
    -- Cache the row "contentWidth" and "contentHeight" because the row bounds can change as children objects are added
    local rowHeight = row.contentHeight
    local rowWidth = row.contentWidth
    
    local label_text = display.newText( row, data_array[index].label, 0, 0, LABEL_FONT, LABEL_FONT_SIZE ) 
	
	label_text.anchorX = 0
	
	if row.isCategory then 
		label_text:setFillColor( ROW_LABEL_COLOR[1], ROW_LABEL_COLOR[2], ROW_LABEL_COLOR[3], ROW_LABEL_COLOR[4] )
		label_text.x = 16
		label_text.y = 14
	else
		label_text:setFillColor( LABEL_COLOR[1], LABEL_COLOR[2], LABEL_COLOR[3], LABEL_COLOR[4] )
		label_text.x = 16
		label_text.y = 12
    end 
    
    
    
    if data_array[index].sub_text ~= nil then
		local sub_text = display.newText( row, data_array[index].sub_text, 0, 0, SUB_FONT, SUB_FONT_SIZE )
		sub_text.anchorX = 0
		sub_text.x = 16
		sub_text.y = 30
		sub_text:setFillColor( SUB_COLOR[1], SUB_COLOR[2], SUB_COLOR[3], SUB_COLOR[4] )
    end 
    --[[
    local arrow = display.newText( row, ">", 0, 0, "04B03", 24 )
    arrow:setFillColor( NAME_COLOR[1], NAME_COLOR[2], NAME_COLOR[3] )
    arrow.x = display.contentWidth - 12
    arrow.y = 25
    --]]
end 

local listOptions = {
        top = display.statusBarHeight,
        height = 410, 
        onRowRender = onRowRender,
        backgroundColor=BACKGROUND_COLOR,
        onRowTouch=onRowTouch,
}
local list = widget.newTableView( listOptions )
 
 
-- Create 100 rows, and two categories to the tableView:
for i=1, #data_array do
        local rowHeight = ROW_HEIGHT
        local rowColor 	= ROW_COLOR
        local lineColor = LINE_COLOR
        local isCategory = false
        
        -- make the 25th item a category
        if i == 5 or i == 10 then
            isCategory 	= true 
            rowHeight 	= ROW_CATEGORY_HEIGHT
            rowColor	= ROW_CATEGORY_COLOR
            lineColor	= LINE_COLOR
        end
    
        -- function below is responsible for creating the row
        list:insertRow{
			rowHeight=rowHeight,
			isCategory=isCategory,
			rowColor=rowColor,
			lineColor=lineColor
        }
end