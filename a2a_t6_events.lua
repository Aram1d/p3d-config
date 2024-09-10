local primerLv = "L:PrimerState"
local wobblePump = "L:FuelPumpManualLever"

local ldgLightLSwitch = "L:LandingLightLeftSwitch"
local ldgLightRSwitch = "L:LandingLightRightSwitch"

local emergGearHandler = "L:LandingGearEmergencyHandle"
local emergGearLock = "L:LandingGearLeverLockPos"


function HandleLockPrimer(_, __, off)
  ipc.writeLvar(primerLv, off == 1 and 0 or 1)
end

function Prime()
  if(ipc.readLvar(primerLv) == 1) then
    ipc.writeLvar(primerLv, 2)
  end
end

function LdgLightToggle()
  local prev = ipc.readLvar(ldgLightLSwitch)
  local next = prev == 1 and 0 or 1
  ipc.writeLvar(ldgLightLSwitch, next)
  ipc.writeLvar(ldgLightRSwitch, next)
end

function WobblePump()
  if(ipc.readLvar(wobblePump) == 0) then
    ipc.writeLvar(wobblePump, 1)
  end
end

function EmergGearLock(_, __, on)
  ipc.writeLvar(emergGearHandler, on)
  ipc.writeLvar(emergGearLock, on)
end

event.button("C", 134, 3, "HandleLockPrimer")
event.button("C", 2,  "Prime")
event.button("C", 3, 3,  "EmergGearLock")
event.button("C", 4,  "LdgLightToggle")
event.button("C", 5,  "WobblePump")
event.button("C", 6,  "ToggleHeadphones")
