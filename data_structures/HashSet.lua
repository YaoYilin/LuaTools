---------------------------------------
-- Name:    HashSet.lua
-- Date:    2019/04/09 21:20:53
-- Author:  Yao Yilin
-- Desc:    A simple hashset. not really hash set, this is based on lua table
--          currently only numbers and strings type are supported
---------------------------------------
local HashSet = { };
local m_Count = 0;
local m_Values = { };

HashSet.__index = HashSet;
HashSet.__len = function()
    return m_Count;
end

function HashSet:New()
    return setmetatable({ }, HashSet);
end

function HashSet:Add(item)
    local contains = m_Values[item] ~= nil;
    m_Values[item] = { };
    if not contains then m_Count = m_Count + 1 end
    return contains;
end

function HashSet:Remove(item)
    local contains = m_Values[item] ~= nil;
    if contains then
        m_Values[item] = nil;
        m_Count = m_Count - 1;
    end
    return contains;
end

function HashSet:Contains(item)
    return m_Values[item] ~= nil;
end

function HashSet:ToArray()
    local t = { };
    for k, v in pairs(m_Values) do
        table.insert(t, k);
    end
    return t;
end

function HashSet:ToHash(items)
    for i = 1, #items do
        self:Add(items[i]);
    end
end

function HashSet:Clear()
    m_Count = 0;
    m_Values = { };
end

setmetatable(HashSet, { __call = HashSet.New });
return HashSet;
