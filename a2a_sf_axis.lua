local handBrakes = require("lib/hand_park_brakes")
local trim = require("lib/trim")


local ldgGearBeamLv = "L:LeverLandingLightBeam"

while true do

  local LDGLightBeamAxis = ipc.axis("B", "Z")
  local calibratedLDGLightBeamAxis = (LDGLightBeamAxis + 11800) / 23400 * 100
  ipc.writeLvar(ldgGearBeamLv, calibratedLDGLightBeamAxis)

  trim()
  handBrakes()

  ipc.sleep(10)
end