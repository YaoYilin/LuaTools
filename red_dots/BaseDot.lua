local BaseDot = { }

function BaseDot:New(key)
    local t = setmetatable( { Key = key, Children = { } }, { __index = self });
    t:Subscribe();
    return t;
end

-- child is an extention of BaseDot
function BaseDot:AddChild(child)
    assert(child, "child can not be nil");
    child.Parent = self;
    table.insert(self.Children, child);
    self:Unsubscribe();
end

-- binding GAMEOBJECT to DATA
function BaseDot:Binding(root)
    assert(root, "binding gameobject failed...");
    self.Root = root.gameObject;
    self:Refresh();
    return self;
end

function BaseDot:Show()
    if not self.Root then return end

    self.Root.gameObject:SetActive(true);
    -- child shown then notice it's parent show
    if self.Parent then self.Parent:Show(); end
end

function BaseDot:Hide()
    if self.Parent then
        if not self.Parent:ShowCondition() then
            self.Parent:Hide();
        end
    end

    if not self.Root then return end
    self.Root.gameObject:SetActive(false);
end

function BaseDot:Refresh()
    if self:ShowCondition() then
        self:Show();
    else
        self:Hide();
    end
    if self.Parent then self.Parent:Refresh(); end
end

-- the dot default display condition 
function BaseDot:DefaultCondition()
    for i = 1, #self.Children do
        if self.Children[i]:ShowCondition() then
            return true;
        end
    end
    return false;
end

-- need override if this is a leaf dot
function BaseDot:ShowCondition()
    return self:DefaultCondition();
end

function BaseDot:Subscribe()
    RedDotManager:Subscribe(self);
end

function BaseDot:Unsubscribe()
    RedDotManager:Unsubscribe(self);
end

return BaseDot;
