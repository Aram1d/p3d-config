local gearHornSilencerLv = "L:GearHornSilencerSwitch"
local carbHeatSwitchLv = "L:Eng1_CarbHeatSwitch"
local superchargerLv = "L:Eng1_SuperchargerSwitch"
local superchargerGuard = "L:Eng1_SuperchargerSwitchGuard"
local headphones = "L:Headphones"


function GearHornSilencer()
  ipc.writeLvar(gearHornSilencerLv, ipc.readLvar(gearHornSilencerLv) == 1 and 0 or 1)
end

function HandleCarbHeat(_, inc)
  if inc == 13 then
    ipc.writeLvar(carbHeatSwitchLv, 0)
  elseif inc == 15 then
    ipc.writeLvar(carbHeatSwitchLv, 100)
  end
end

function HandleSupercharger(_, inc)
  local prev = ipc.readLvar(superchargerLv)
  if inc == 18 and prev < 2 then
    ipc.writeLvar(superchargerGuard, 1)
    ipc.writeLvar(superchargerLv, prev + 1)
  elseif inc == 20 and prev > 0 then
    ipc.writeLvar(superchargerGuard, prev == 1 and 0 or 1)
    ipc.writeLvar(superchargerLv, prev -1)
  end
end

function ToggleHeadphones()
  ipc.writeLvar(headphones, ipc.readLvar(headphones) == 1 and 0 or 1)
end

event.button("C", 0, "GearHornSilencer")
event.button("C", 13, "HandleCarbHeat")
event.button("C", 15, "HandleCarbHeat")
event.button("C", 18, "HandleSupercharger")
event.button("C", 20, "HandleSupercharger")
event.button("C", 6, "ToggleHeadphones")