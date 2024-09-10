local trim = require("lib/trim")
local parkBrakes = require("lib/park_brakes")

while true do
  trim()
  parkBrakes()
  ipc.sleep(10)
end