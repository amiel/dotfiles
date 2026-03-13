-- You can use this to debug the mappings used by the "Other" plugin.
--
-- Usage:
--
-- find ~/work/venice/spec -name '*_spec.rb' | sort | uniq | lua test_other_mappings.lua
--
for line in io.stdin:lines() do
  local mappings = dofile("other_mappings.lua")
  local match = nil
  local pattern = nil
  local path = string.gsub(line, "$", "")

  for _, mapping in ipairs(mappings) do
    pattern = mapping["pattern"]
    if not pattern then
      break
    end

    match = string.match(path, pattern)

    if match then
      break
    end
  end
  if not match then
    print(path)
  end
end
