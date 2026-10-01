local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

return {
  s('class', {
    t 'public class ',
    i(1, 'ClassName'),
    t { ' {', '\t' },
    i(0),
    t { '', '}' },
  }),

  s('main', {
    t { 'public static void main(String[] args) {', '\t' },
    i(0),
    t { '', '}' },
  }),
}
