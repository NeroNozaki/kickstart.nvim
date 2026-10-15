vim.pack.add({
  { src = 'https://github.com/kmonad/kmonad-vim' }
})
local ok, kmonad = pcall(require, 'kmonad-vim')
if ok then
  kmonad.setup()
end
