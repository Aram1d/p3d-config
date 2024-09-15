local parkBrakes = require("lib/park_brakes")
local trim = require("lib/trim")



while true do
  local rowAxis = ipc.axis("B", "Z")
  local calibratedAxis = 100 - (rowAxis + 11800) / 23400 * 100

  ipc.writeLvar("L:Eng1_RadiatorLeverPos", calibratedAxis)

  parkBrakes()
  trim()

  ipc.sleep(10)
end