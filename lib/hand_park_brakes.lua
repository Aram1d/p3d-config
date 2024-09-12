local joyUtils = require("lib/joy_utils")

local HAND_BRAKE_TRIGGER = -16000

local function handBrakeAxis() return ipc.axis("C", "T") end
local function parkBrakeEngaged() return ipc.readUW(0x0BC8) == 32767 end
local function parkBrakeDisengaged() return ipc.readUW(0x0BC8) == 0 end

local function handBrakeEngaged()
  return handBrakeAxis() < HAND_BRAKE_TRIGGER
end

local function parkBrakePulled()
  return joyUtils("C").btnOn(6)
end

return function()
  if(handBrakeEngaged()) then
    if parkBrakePulled() and parkBrakeDisengaged() then
      ipc.control(65752, 0)
    elseif not parkBrakePulled() and parkBrakeEngaged() then
      ipc.control(65752, 0)
    end
  end
end