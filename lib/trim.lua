-- Trim input offsets
local ELEVATOR_TRIM_INPUT = 0x66C0
local RUDDER_TRIM_INPUT = 0x66C1

-- Trim position offsets

local ELEVATOR_TRIM = 0x0BC0
local RUDDER_TRIM = 0x0C04

-- Constants
local MIN_DEF = 400;

local elv_deflection = 0;
local rud_deflection = 0;

local function updateDeflection()
  local xAxis = ipc.axis("C", "S")
  local zAxis = ipc.axis("C", "R")
  if(math.abs(xAxis) > math.abs(zAxis)) then
    elv_deflection = xAxis
    rud_deflection = 0
  else
    elv_deflection = 0
    rud_deflection = zAxis
  end
end

return function()
  updateDeflection()

  -- Elevator
  local elv_abs_deflection = math.abs(elv_deflection);
  local elv_correctionFactor = (elv_deflection / 1000 * elv_abs_deflection / 1000) / 2;
      if elv_abs_deflection > MIN_DEF then
        ipc.writeSW(ELEVATOR_TRIM, ipc.readSW(ELEVATOR_TRIM) + elv_correctionFactor )
  end

  -- Rudder
  local rud_abs_deflection = math.abs(rud_deflection);
  local rud_correctionFactor = (rud_deflection / 2000 * rud_abs_deflection / 2000) / 2;
      if rud_abs_deflection > MIN_DEF then
        ipc.writeSW(RUDDER_TRIM, ipc.readSW(RUDDER_TRIM) - rud_correctionFactor )
  end

end
