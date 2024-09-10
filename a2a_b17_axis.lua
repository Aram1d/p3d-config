
local trim = require("lib/trim")
local parkBrakes = require("lib/park_brakes")

while true do

  -- Turbo
  local rowTurboAxis = ipc.axis("B", "X")
  local calibratedTurboAxis = (rowTurboAxis + 11800) / 23400 * 100

  if ipc.readLvar("FullDial") == 0 then
    if calibratedTurboAxis >= 80 then calibratedTurboAxis = 80
    end
  end
  ipc.writeLvar("L:DialTurbocharger", calibratedTurboAxis)


  --Propellers 
  local rowLPPAxis = ipc.axis("B", "Z")
  local rowRPPAxis = ipc.axis("B", "U")

  local calibratedLPPAxis = (rowLPPAxis + 11800) / 23400 * 100
  local calibratedRPPAxis = (rowRPPAxis + 11800) / 23400 * 100
  if ipc.readLvar("L:Engine1Checked") == 0 then
    ipc.writeLvar("L:RPMLever1Position", calibratedLPPAxis)
  end
  if ipc.readLvar("L:Engine2Checked") == 0 then
    ipc.writeLvar("L:RPMLever2Position", calibratedLPPAxis)
  end

  if(ipc.readLvar("L:Engine3Checked") == 0) then
    ipc.writeLvar("L:RPMLever3Position", calibratedRPPAxis)
  end
  if(ipc.readLvar("L:Engine4Checked") == 0) then
    ipc.writeLvar("L:RPMLever4Position", calibratedRPPAxis)
  end

  -- Intercoolers
  local rowIntercoolerAxis = ipc.axis("B", "Y")
  local calibratedIntercoolersAxis = 100-(rowIntercoolerAxis + 11800) / 23400 * 100

  if ipc.readLvar("L:Engine1Checked") == 0 then
    ipc.writeLvar("L:Eng1_IntercoolerLever", calibratedIntercoolersAxis)
  end
  if ipc.readLvar("L:Engine2Checked") == 0 then
    ipc.writeLvar("L:Eng2_IntercoolerLever", calibratedIntercoolersAxis)
  end
  if ipc.readLvar("L:Engine3Checked") == 0 then
    ipc.writeLvar("L:Eng3_IntercoolerLever", calibratedIntercoolersAxis)
  end
  if ipc.readLvar("L:Engine4Checked") == 0 then
    ipc.writeLvar("L:Eng4_IntercoolerLever", calibratedIntercoolersAxis)
  end

  -- Trim
  trim()

  -- Park brake
  parkBrakes()

  ipc.sleep(10)
end
