---------------------------------------
-- Name:   ServerTime.lua
-- Date:   2019/03/18 21:17:37
-- Author: Yao Yilin
-- Desc:   游戏中，客户端使用服务器时间。
--         Unity3D引擎，使用了 C# 的 DateTime、TimeSpan、DateTimeKind
--         服务器以 Java 语言为例，其他语言同理
---------------------------------------

local DateTime = System.DateTime;
local TimeSpan = System.TimeSpan;
local DateTimeKind = System.DateTimeKind;

local Time = UnityEngine.Time;

local deltaTime = 0; -- 单位是毫秒
local serverTime = 0;

local function RealtimeSinceStartup()
    return Time.realtimeSinceStartup * 1000 - deltaTime;
end

-- C#的时间是从1年1月开始的，Java的是从1970年1月1日开始的
local origin = DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc);

local ServerTime = { }

-- 只有通过这个函数校正过后，再调用其他函数才会是有效值
-- time ， Java 的毫秒数时间
function ServerTime:Modify(time)
    deltaTime = Time.realtimeSinceStartup * 1000;
    serverTime = time;
end

function ServerTime:CurrentTime()
    return origin:ToLocalTime():AddMilliseconds(serverTime + RealtimeSinceStartup());
end

return ServerTime;
