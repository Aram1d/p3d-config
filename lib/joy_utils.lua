local function isButtonSet(value, bitPos)
    return (value % 2^(bitPos+1)) > 2^(bitPos-1)
  end

return function (joyLetter)
  local btns = ipc.buttons(joyLetter);
  return {
    btnOn = function (btnIdx)
      return isButtonSet(btns, btnIdx)
    end,
  }
end