ipc.runlua("a2a_j3_axis")

local fuelLv = "L:Eng1_FuelCutOffSwitch"
local carbHeatLv = "Eng1_CarbHeatSwitch"
local primerLv = "L:PrimerOn"

function ToggleFuelSelector()
  ipc.writeLvar(fuelLv, ipc.readLvar(fuelLv) == 1 and 0 or 1)
end

function Prime()
  ipc.writeLvar(primerLv, 1)
end

function ToggleCarbHeat()
  ipc.writeLvar(carbHeatLv, ipc.readLvar(carbHeatLv) == 1 and 0 or 1)
end

event.button("C", 3, "ToggleFuelSelector")
event.button("C", 4, "Prime")
event.button("C", 5, "ToggleCarbHeat")