-- Written by Tuhkis1
local pullevent = os.pullEvent
os.pullEvent = os.pullEventRaw

local w, h = term.getSize()
local instruction = 'Type your password.'
local y_middle = h * 0.5
local guess = ''
local run = true

-- get password
local password
local f = fs.open('/.passwd', 'r')
if f == nil then
  print('No password set in ".passwd"')
  print('Press a key to continue...')
  read()
  run = false
else
  password = f.readLine()
  f.close()
  if #password > 64 then
    print('Dangerously long password. A password cannot be longer than 64 characters.')
    print('Press a key to continue...')
    read()
    run = false
  end
end

-- get splash text.
local splash = 'lock by Tuhkis'
if fs.exists('.locksplash') then
  f = fs.open('.locksplash', 'r')
  splash = f.readLine()
  f.close()
end

while run do
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
      run = false
      break
    else
      guess = ''
    end
  else
    local e1, c1 = os.pullEvent('char')
    -- should be true no matter what, but apparantly isn't. :shrug:
    if e1 == 'char' then
      if #guess < 64 then
        guess = guess .. c1
      end
    end
  end
end
term.clear()
term.setCursorPos(1, 1)
term.setTextColor(colors.white)

-- EOF
