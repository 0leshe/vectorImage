local vector = require("vectorImage")
local gui = require("gui")
local mode = 'example_03'

-----------------------------------------------------

workspace = gui.workspace()

workspace:addChild(gui.panel(1, 1, workspace.width, workspace.height, 0x262626))

local canvas = workspace:addChild(vector.newCanvas(3, 2, 20, 10))

canvas:addShape(1,2, "rectangle", 21, 11, 0x444444,'example_01')
canvas:addShape(11, 7, "ellipse", 9,4, 0xFFFFFF,'example_02')
canvas:addShape(2,3, "line", 20, 11, 0xFF0000,'example_03')
-----------------------------------------------------

local text1 = workspace:addChild(gui.text(2,47,0xFFFFFF,'3. rectangle'))
local text2 = workspace:addChild(gui.text(2,48,0xFFFFFF,'2. ellipse'))
local text3 = workspace:addChild(gui.text(2,49,0xFFFFFF,'1. line'))
local current = workspace:addChild(gui.text(6+#'recangle',49,0xFF0000,'<'))

local function update()
  text1.text = '3. ' .. canvas.shapes[1].type
  text2.text = '2. ' .. canvas.shapes[2].type
  text3.text = '1. ' .. canvas.shapes[3].type
  for i = 1,3 do
    if canvas.shapes[i].name == mode then
      current.localY = 46 + i
      current.localX = 6 + #canvas.shapes[i].type
    end
  end
  workspace:draw()
end

workspace.eventHandler = function(_,_,e1,_,_,key)
  if e1 == 'key_up' then
    if key == 16 then
      canvas:lower(mode)
      update()  
    elseif key == 18 then
      canvas:upper(mode)
      update()
    elseif key == 31 then
      workspace:stop()
    elseif key == 19 then
      mode = canvas.shapes[1].name
      update()
    elseif key == 33 then
      mode = canvas.shapes[2].name
      update()
    elseif key == 47 then
      mode = canvas.shapes[3].name
      update()
    end
  end
end

workspace:draw()
workspace:start()
