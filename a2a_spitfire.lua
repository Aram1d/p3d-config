ipc.runlua("a2a_sf_axis")

local gearHornSilencerLv = "L:GearHornSilencerSwitch"
local primerLv = "L:PrimerState";


local oxyMask = "L:OxyMaskOn"
local oxyMaster = "L:OxyMaster"

local ldgGearEmergencyLV =  "L:LandingGearEmergencyHandle"
local headphones= "L:Headphones"

local ldgLightExtendLv = "L:LandingLightExtendSwitch"
local ldgLightSwLv = "L:LandingLightSwitch"

local bottTank = "L:BottTankOn"



function GearHornSilencer()
  ipc.writeLvar(gearHornSilencerLv, ipc.readLvar(gearHornSilencerLv) == 1 and 0 or 1)
end

-- Primer

function HandleLockPrimer(_, __, off)
  ipc.writeLvar(primerLv, off == 1 and 0 or 1);
end;

function Prime()
  if ipc.readLvar(primerLv) == 1 then
    ipc.writeLvar(primerLv, 2);
  end;
end;

function ToggleOxygen()
  local wasOff = ipc.readLvar(oxyMaster) == 0
  ipc.writeLvar(oxyMask, wasOff and 1 or 0)
  ipc.writeLvar(oxyMaster, wasOff and 100 or 0)
end

function ToggleGearEmergencyPressure()
  ipc.writeLvar(ldgGearEmergencyLV, ipc.readLvar(ldgGearEmergencyLV) == 0 and 1 or 0)
end

function ToggleHeadphones()
  ipc.writeLvar(headphones, ipc.readLvar(headphones) == 0 and 1 or 0)
end

-- Landing lights

function RaiseLdgLight()
  ipc.writeLvar(ldgLightExtendLv, 0)
end

function LowerLdgLight()
  ipc.writeLvar(ldgLightExtendLv, 1)
end

function ToggleLeftLdg()
  ipc.writeLvar(ldgLightSwLv, ipc.readLvar(ldgLightSwLv) == 0 and 1 or 0)
end

function ToggleRightLdg()
  ipc.writeLvar(ldgLightSwLv, ipc.readLvar(ldgLightSwLv) == 2 and 1 or 2)
end

-- Bott tank gauge

function ToggleBott(_, __, on)
  ipc.writeLvar(bottTank, on)
end

function ToggleHeadset()
  local prev = ipc.readLvar("L:Headphones")
  ipc.writeLvar("L:Headphones", prev == 1 and 0 or 1);
  ipc.writeLvar("L:Headgear1", prev == 1 and 0 or 1);
  ipc.writeLvar("L:Headgear2", prev == 1 and 0 or 1);
  ipc.writeLvar("L:Headgear3", prev == 1 and 0 or 1);
  ipc.writeLvar("L:Headgear4", prev == 1 and 0 or 1);
  ipc.writeLvar("L:Headgear5", prev == 1 and 0 or 1);
  ipc.writeLvar("L:Headgear6", prev == 1 and 0 or 1);
end;

event.button("C", 0, "GearHornSilencer")
event.button("C", 2, "Prime")
event.button("C", 134, 3, "HandleLockPrimer");
event.button("C", 3, "ToggleGearEmergencyPressure")
event.button("C", 4, "ToggleHeadset")
event.button("C", 6, "ToggleHeadphones")
event.button("C", 18, "RaiseLdgLight")
event.button("C", 20, "LowerLdgLight")
event.button("C", 19, "ToggleRightLdg")
event.button("C", 21, "ToggleLeftLdg")
event.button("C", 22, 3, "ToggleBott")