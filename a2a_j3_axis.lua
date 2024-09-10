local cabinHeatLv = "L:CabinHeat"

while true do
local rowCabHeatAxis = ipc.axis("B", "Z")
local calibratedCabHeatAxis = 100 - (rowCabHeatAxis + 11800) / 23400 * 100
ipc.writeLvar(cabinHeatLv, calibratedCabHeatAxis)

ipc.sleep(10)
end