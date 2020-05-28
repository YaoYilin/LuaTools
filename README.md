# LuaTools

---

## print_table / 打印一个 table
  出处来自 [stackoverflow](http://stackoverflow.com/questions/9168058/how-to-dump-a-table-to-console)
  用法：
```lua
t = {  a =   {    [1] = "A",    [2] = "B",    [3] = "C"  },
       b =   {    c = {m = "AAA"},    d = {n = "BBB"}  }}

print_table(t)
```
输出结果为：
```lua
{
        ['a'] = {
                [1] = 'A',
                [2] = 'B',
                [3] = 'C'
        },
        ['b'] = {
                ['c'] = {
                        ['m'] = 'AAA'
                },
                ['d'] = {
                        ['n'] = 'BBB'
                }
        }
}
stack traceback:
        stdin:93: in function 'print_table'
        (...tail calls...)
        [C]: in ?

```
如果不想要函数调用堆栈的话可以注释掉：`table.insert(output, debug.traceback())`

## server time / 服务器时间
  这个主要是给 Unity3D 开发者使用的函数，通过服务器下发的时间，客户端本地校准为服务器时间。
  用法：
```lua
local serverTime = require("ServerTime");
-- time 为 服务器下发的时间，
serverTime:Modify(time);
print(serverTime:CurrentTime():ToString());
```

## utf8
   Lua 5.3 版本提供了对 UTF8 的支持，这个也是在其基础上扩展的。下面加粗字体是扩展的方法。
   * utf8.char (···)
   * utf8.charpattern
   * utf8.codes (s)
   * utf8.codepoint (s [, i [, j]])
   * utf8.len (s [, i [, j]])
   * utf8.offset (s, n [, i])
   
   * **utf8.sub(s, b, l)**

---

## red_dots / 游戏中的小红点管理器
  这个实现是把数据和 GameObject 分离的实现，小红点是否显示，只需要管理最底层的“叶子”节点对应的显示逻辑，然后每个节点发生变化再通知其父节点，如果没有变化则不再继续通知。
  用法：
```lua
-- RedDots.lua
-- 每一个小红点都有其对应的一个 Key
RedDots =
{
    DOT_LEVEL_1 = SerialKey(),
    DOT_LEVEL_2_1 = SerialKey(),
    DOT_LEVEL_2_2 = SerialKey(),
    DOT_LEVEL_2_3_1 = SerialKey(),
    DOT_LEVEL_2_3_2 = SerialKey(),
}

-- 顶节点
DotLevel1 = BaseDot:New(RedDots.DOT_LEVEL_1);

-- 一级子节点1
DotLevel2_1 = BaseDot:New(RedDots.DOT_LEVEL_2_1);
function DotLevel2_1:ShowCondition()
    if x and y then return true else return false end
end

-- 一级子节点2
DotLevel2_2 = BaseDot:New(RedDots.DOT_LEVEL_2_2);

-- 二级子节点1
DotLevel2_3_1 = BaseDot:New(RedDots.DOT_LEVEL_2_3_1);
function DotLevel2_3_1:ShowCondition()
    if a and b then return true else return false end
end

-- 二级子节点2
DotLevel2_3_2 = BaseDot:New(RedDots.DOT_LEVEL_2_3_2);
function DotLevel2_3_2:ShowCondition()
    if m and n then return true else return false end
end

-- 顶级节点添加两个二级子节点
DotLevel1:AddChild(DotLevel2_1);
DotLevel1:AddChild(DotLevel2_2);

-- 二级子节点添加两个三级子节点
DotLevel2_2:AddChild(DotLevel2_3_1);
DotLevel2_2:AddChild(DotLevel2_3_2);
```

`小红点结构`（层级从左向右看）
```
            DotLevel2_1
DotLevel1
                            DotLevel2_3_1
            DotLevel2_2
                            DotLevel2_3_2
```

  最后，每个小红点不要忘记了在“适当”的时候绑定一下 UI 对应的 GameObject，`BaseDot:Binding(root)`。当数据发生变化的时候，通知到 RedDotManager，调用一下 `RedDotManager:RefreshByKey(key)`
