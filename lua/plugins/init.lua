local specs = {}

-- Load all plugin specs from individual files
table.insert(specs, require("plugins.colorscheme"))
table.insert(specs, require("plugins.icons"))
table.insert(specs, require("plugins.neo-tree"))
table.insert(specs, require("plugins.telescope"))
table.insert(specs, require("plugins.treesitter"))
table.insert(specs, require("plugins.tokyonight"))

-- Flatten the nested tables into a single spec list
local result = {}
for _, spec_table in ipairs(specs) do
  for _, plugin_spec in ipairs(spec_table) do
    table.insert(result, plugin_spec)
  end
end

return result
