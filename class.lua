--[[----------------------------------------------------------------------
desc:   base class defination
        c++ like
--]]----------------------------------------------------------------------

local function getSuper(t, k)
    if type(t)~="table" then return end
    if t[k] ~=nil then return t[k] end
    return getSuper(t.super)
end


function class(super)
    local class_type = {}

    class_type.ctor  = false
    class_type.super = super
    class_type.new   = function (...)
                        local obj = {}
                        do -- a closure...  construct func.
                            local create
                            create = function(c, ...)
                                for k, v in pairs(c) do
                                    local v2 = obj[k]
                                    if v2==nil then
                                        local vT = type(v2)
                                        if vT=="table" then
                                            obj[k]={}
                                        elseif vT~="function" and vT~="userdata" and vT~="thread" then
                                            obj[k]=v
                                        end
                                    end
                                end

                                if c.super then
                                    create(c.super, ...)
                                end
    
                                if c.ctor then
                                    c.ctor(obj, ...)
                                end
                            end
                            create(class_type, ...)
                        end

                        setmetatable(obj, {
                                        __index = function (t, k)
                                            if class_type then
                                                return class_type[k]
                                            end
                                        end})
                        return obj
                       end

    local vtbl = {}
    setmetatable(class_type, {
                __newindex = function (t, k, v)
                                vtbl[k]=v
                             end,
                __index = function (t, k)
                             return vtbl[k]
                          end})


    if super then
        setmetatable(vtbl, {__index=
                            function (t, k)
                                return getSuper(super, k)
                            end})
    end

    return class_type
end