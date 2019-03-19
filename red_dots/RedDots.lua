local BaseDot = require("BaseDot");

local id = 0;
local function SerialKey()
    id = id + 1;
    return id;
end

RedDots = 
{
	DOT_LEVEL_1 = SerialKey(),
	DOT_LEVEL_2_1 = SerialKey(),
	DOT_LEVEL_2_2 = SerialKey(),
	DOT_LEVEL_2_3_1 = SerialKey(),
	DOT_LEVEL_2_3_2 = SerialKey(),
}

DotLevel1 = BaseDot:New(RedDots.DOT_LEVEL_1);

DotLevel2_1 = BaseDot:New(RedDots.DOT_LEVEL_2_1);
function DotLevel2_1:ShowCondition()
	if x and y then return true else return false end
end

DotLevel2_2 = BaseDot:New(RedDots.DOT_LEVEL_2_2);

DotLevel2_3_1 = BaseDot:New(RedDots.DOT_LEVEL_2_3_1);
function DotLevel2_3_1:ShowCondition()
	if a and b then return true else return false end
end

DotLevel2_3_2 = BaseDot:New(RedDots.DOT_LEVEL_2_3_2);
function DotLevel2_3_2:ShowCondition()
	if m and n then return true else return false end
end

DotLevel1:AddChild(DotLevel2_1);
DotLevel1:AddChild(DotLevel2_2);

DotLevel2_2:AddChild(DotLevel2_3_1);
DotLevel2_2:AddChild(DotLevel2_3_2);
