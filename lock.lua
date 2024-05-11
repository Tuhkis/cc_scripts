-- Written by Tuhkis1
local pullevent = os.pullEvent
os.pullEvent = os.pullEventRaw

local w, h = term.getSize()
local instruction = 'Type your password.'
local y_middle = h * 0.5

local guess = ''

-- get password
local f = fs.open('.passwd', 'r')
if f == nil then
  print('No password set in ".passwd"')
  read()
  os.reboot()
end
local password = f.readLine()
f.close()

-- get splash text.
local splash = 'lock by Tuhkis'
if fs.exists('.locksplash') then
  f = fs.open('.locksplash', 'r')
  splash = f.readLine()
  f.close()
end

while true do
  term.clear()
  term.setCursorPos(w * 0.5 - #instruction * 0.5, y_middle)
  term.setTextColor(colors.yellow)
  term.write(instruction)
  term.setCursorPos(w * 0.5 - #guess * 0.5, y_middle + 1)
  term.setTextColor(colors.lightBlue)
  for i = 1, #guess do
    term.write('*')
  end
  term.setCursorPos(w * 0.5 - #splash * 0.5, y_middle - 2)
  term.setTextColor(colors.green)
  term.write(splash)
  local e, c = os.pullEvent('key')
  if c == keys.backspace and guess ~= '' then
    guess = guess:sub(1, -2)
  elseif c == keys.enter then
    if guess == password then
      break
    else
      guess = ''
    end
  else
    local e1, c1 = os.pullEvent('char')
    guess = guess .. c1
  end
    
  sleep(1 / 22)
end
term.clear()
term.setCursorPos(1, 1)
term.setTextColor(colors.white)

-- EOF
