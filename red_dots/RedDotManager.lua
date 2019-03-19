RedDotManager = { }

function RedDotManager:Initialize()
    self.LeafMap = { }
end

function RedDotManager:RefreshAll()
	for k, v in pairs(self.LeafMap) do
		v:Refresh();
	end
end

function RedDotManager:RefreshByKeys(keys)
	if not keys then return end
	if type(keys) ~= 'table' then return end
	for k, v in pairs(keys) do
		self:RefreshByKey(v);
	end
end

function RedDotManager:RefreshByKey(key)
	local dot = self.LeafMap[key];
	if dot then
		dot:Refresh();
	end
end

function RedDotManager:Subscribe(dot)
    assert(not self.LeafMap[dot.Key], "may be duplicate keys in red dot system, please remove the duplicate or reacquire a new key.");
    self.LeafMap[dot.Key] = dot;
end

function RedDotManager:Unsubscribe(dot)
    self.LeafMap[dot.Key] = nil;
end
