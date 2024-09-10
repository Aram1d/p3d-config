
local parkBrakes = require("lib/park_brakes")
local trim = require("lib/trim")

while true do

  -- Carb air control
  local carbAirRowAxis = ipc.axis("B", "Z")
  local calibratedCarbAirAxis = (carbAirRowAxis + 11800) / 23400 * 100
  ipc.writeLvar("L:Eng1_CarbAirSwitch", calibratedCarbAirAxis)

  -- Park brake
  parkBrakes()
  trim()

  ipc.sleep(10)
end