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


