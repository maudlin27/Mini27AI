---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by maudlin27.
--- DateTime: 17/06/2024 17:17

--******************************************************************************************************
-- MIT LICENSE
-- Code from FAF is assumed to fall under Copyright (c) 2022 Willem 'Jip' Wijnia:
-- Copyright (c) 2022 Willem 'Jip' Wijnia
--
-- Permission is hereby granted, free of charge, to any person obtaining a
-- copy of this software and associated documentation files (the
-- "Software"), to deal in the Software without restriction, including
-- without limitation the rights to use, copy, modify, merge, publish,
-- distribute, sublicense, and/or sell copies of the Software, and to
-- permit persons to whom the Software is furnished to do so, subject to
-- the following conditions:
--
-- The above copyright notice and this permission notice shall be included
-- in all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
-- OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
-- MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
-- IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
-- CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
-- TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
-- SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
--******************************************************************************************************

bFAFActive = false
bLoudModActive = false
bSteamActive = false

function ConsiderIfLoudActive()
    if not(bFAFActive) and not(bSteamActive) then
        bLoudModActive = true
        --Run 1-off setup
        --'lua/system/utils.lua':
        --Code copied from FAF project
        function table.unhash(t)
            if not t then return {} end -- prevents looping over nil table
            local r = {}
            local n = 1
            for k, v in t do
                if v then
                    r[n] = k -- faster than table.insert(r, k)
                    n = n + 1
                end
            end
            return r
        end

        --'/lua/system/debug.lua':
        local type = type

        --- Determines the size in bytes of the given element
        ---@param element any
        ---@param ignore? table<string, boolean>     # List of key names to ignore of all (referenced) tables
        ---@return number
        debug.allocatedrsize = function(element, ignore)
            ignore = ignore or { }

            -- has no allocated bytes
            if element == nil then
                return 0
            end

            -- applies to tables and strings, to prevent counting them multiple times
            local seen = {}

            -- prepare stack to prevent recursion
            local allocatedSize = 0
            local stack = { element }
            local head = 2

            while head > 1 do

                head = head - 1
                local value = stack[head]
                stack[head] = nil

                local size = debug.allocatedsize(value)

                -- size of usual value
                if size == 0 then
                    allocatedSize = allocatedSize + 8

                    -- size of string
                elseif type(value) ~= 'table' then
                    if not seen[value] then
                        seen[value] = true
                        allocatedSize = allocatedSize + size
                    end

                    -- size of table
                else
                    if not seen[value] then
                        allocatedSize = allocatedSize + size
                        seen[value] = true
                        for k, v in value do
                            if not ignore[k] then
                                stack[head] = v
                                head = head + 1
                            end
                        end
                    end
                end
            end

            return allocatedSize
        end



    end
end
function BrainBeginSession()
    bFAFActive = true
    bLoudModActive = false
    bSteamActive = false
end