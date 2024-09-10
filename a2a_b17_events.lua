function ToggleGroundStuffs()
  if(ipc.axis("C", "T") < -10000) then
    ipc.writeLvar("L:VisGroundStuff",  ipc.readLvar("L:VisGroundStuff") == 1 and 0 or 1)
  else
    ipc.writeLvar("L:CarbFilterOnSwitch",  ipc.readLvar("L:CarbFilterOnSwitch") == 1 and 0 or 1)
  end
end

function HandleThrottleLock(_, btn, down)
  if(btn == 134 and down == 1) then
    ipc.writeLvar("L:ThrottleLeverLock", 0)
  elseif (btn == 134) then
    ipc.writeLvar("L:ThrottleLeverLock", 1)
  elseif(btn == 2 and down) then
    ipc.writeLvar("L:ThrottleLeverLock", ipc.readLvar("L:ThrottleLeverLock") == 2 and 1 or 2)
  end
end

event.button("C", 6, "ToggleGroundStuffs")
event.button("C", 134, 3, "HandleThrottleLock")
event.button("C", 2, "HandleThrottleLock")