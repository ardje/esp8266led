local esp={}
local Esp={_meta={__index=esp},_list={}}
function Esp:fromtopic(topic)
	local id=topic:match"/esp/([^/]+)/"
	if id == nil then return id end
	if self._list ~= nil and self._list[id] ~= nil then return self._list[id] end
	return self:new(id)
end
function Esp:new(n)
	print("create esp:",n)
	self._list = self._list or {}
	local o={_id=n}
	setmetatable(o,Esp._meta)
	self._list[n]=o
	return o
end
local function send(id,data)
	local self=Esp
	local queue="/esp/"..id.."/lua"
	io.write(("Send(%s,%s)\n"):format(queue,data))
	print(pcall(self._aclient.publish,self._aclient,queue,data))
end
function esp:send(data)
	if type(data)=="table" then
		data=table.concat(data)
	end
	send(self._id,data)
end
function esp:boot()
	self:send"dofile[[chaseonce.lua]]"
end
function esp:upload(filename)
	esp._process=coroutine.wrap(function()
		local file=io.open(filename)
		local data=file:read"*a"
		file:close()
		self:send([[F=file.open
	end)
end
function esp:continue(...)
	if esp._process ~= nil and type(esp._process) == "function" then
		return esp._process(...)
	end
end
return Esp
