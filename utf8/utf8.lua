local utf8 = utf8;

-- s: 输入的字符串
-- b: 开始截取的下标，从 1 开始
-- l: 截取的长度。
function utf8.sub(s, b, l)
    if not s or type(s) ~= "string" then
        assert("error input string.");
    end
    local i , j = 1, 0;
    local t = { };
    for p, c in utf8.codes(s) do
        if i >= b then
            table.insert(t, c);
            j = j + 1;
            if j == l then
                break;
            end
        end
        i = i + 1;
    end
    return utf8.char(table.unpack(t));
end

return utf8;
