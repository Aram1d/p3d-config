local PARK_BRAKE_TRIGGER = -10000
local TOE_BRAKE_TRIGGER = 12000

local function parkBrakeAxis() return ipc.axis("C", "T") end
local function parkBrakeEngaged() return ipc.readUW(0x0BC8) == 32767 end
local function parkBrakeDisengaged() return ipc.readUW(0x0BC8) == 0 end

local function toeBrakesEngaged()
  return ipc.axis("A", "X") > TOE_BRAKE_TRIGGER and ipc.axis("A", "Y") > TOE_BRAKE_TRIGGER
end

return function()
  if(toeBrakesEngaged()) then
    local parkBrakePulled = parkBrakeAxis() < PARK_BRAKE_TRIGGER

    if parkBrakePulled and parkBrakeDisengaged() then
      ipc.control(65752, 0)
    elseif not parkBrakePulled and parkBrakeEngaged() then
      ipc.control(65752, 0)
    end
  end
end
