ipc.runlua("a2a_p40_axis");

local primerLv = "L:PrimerState";
local landingLightSwLv = "L:LandingLightSwitch"
local eng1StarterSwLv = "L:Eng1_StarterSwitch"
local propControlSwLv = "L:Eng1_PropellerControlSwitch"

-- Primer

function HandleLockPrimer(_, __, off)
  ipc.writeLvar(primerLv, off == 1 and 0 or 1);
end;

function Prime()
  if ipc.readLvar(primerLv) == 1 then
    ipc.writeLvar(primerLv, 2);
  end;
end;

-- Ldg light

function LandingLight(_, dir)
  local prev = ipc.readLvar(landingLightSwLv);
  ipc.writeLvar(landingLightSwLv, dir == 15 and (prev == 2 and 1 or 2) or (prev == 0 and 1 or 0));
end;

-- Starter

function Starter(_, dir, on)
  ipc.writeLvar(eng1StarterSwLv, on == 1 and (dir == 18 and 2 or 0) or 1);
end;

-- Prop control

function PropControl(_, dir, on)
  if(dir == 32) then
    ipc.writeLvar(propControlSwLv, on == 1 and 1 or 0);
  else
    ipc.writeLvar(propControlSwLv, on == 1 and (dir == 37 and 2 or 3) or 1);
  end
end;

event.button("C", 134, 3, "HandleLockPrimer");
event.button("C", 2, "Prime");


event.button("C", 13,  "LandingLight");
event.button("C", 15,  "LandingLight");

event.button("C", 18, 3, "Starter");
event.button("C", 20, 3, "Starter");

event.button("C", 32, 3, "PropControl");
event.button("C", 35, 3, "PropControl");
event.button("C", 37, 3, "PropControl");




