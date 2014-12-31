-- module honorific
-- @return Univ. of Anywhere formatted honorific suffix

local M, t = M or {}, t or {}

t['phd']    = {'Doctor of Philosophy','\\textbf{MPhil}'}
t['msc']    = {'MSc', 'MSc'}
t['obe']    = {'OBE', '\\textit{Stiff Upper Lip}'}
t['mr']     = {'Mr', '\\textup{Mr}'}
t['dr']      = {'Dr', '\\textup{Dr}'}

-- str  the string to split
-- pat is the pattern
-- from lua.org site

local function split(str, pat)
   local t = {}
   local fpat = "(.-)" .. pat
   local last_end = 1
   local s, e, cap = str:find(fpat, 1)
   while s do
      if s ~= 1 or cap ~= "" then
  table.insert(t, cap)
      end
      last_end = e+1
      s, e, cap = str:find(fpat, last_end)
   end
   if last_end <= #str then
      cap = str:sub(last_end)
      table.insert(t, cap)
   end
   return t
end

lpeg.locale(lpeg)   -- adds locale entries into 'lpeg' table



local function split_honorific(str)
   return split(str, '[%s]')
end

M.honorific = function (text)
-- split string
text = split_honorific(text)

for k,v in ipairs (text) do
  local tmp = string.lower(v)
         tmp = string.gsub(tmp,'%.','')

  if t[tmp]  then
     tex.print(t[tmp][1])
  else
      tex.print(v)
  end
end

end

local actorpattern  = [[\begin{actors}]]..[[(.-)]]..[[\end{actors}]]
local math = [[%$+(.-)%$+]]
local fixstr = [[{id:78749,
                      \begin{actors}%
                         Hrithik Roshan
                     \end{actors}%
                     $$ a + b = 3 $$ and $test = 22$
                      Vijay Deenanath]]

local print = tex.print
for name in string.gmatch(fixstr, math,'..') do
    tex.print(name)
end

return M
