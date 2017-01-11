--[==[
下面是非递归的回溯方法的实现：
/// 求从数组a[1..n]中任选m个元素的所有组合。
/// a[1..n]表示候选集，m表示一个组合的元素个数。
/// 返回所有组合的总数。
int combine(int a[], int n, int m)
{
 m = m > n ? n : m;

 int* order = new int[m+1];
 for(int i=0; i<=m; i++)
  order[i] = i-1;            // 注意这里order[0]=-1用来作为循环判断标识

 int count = 0;
 int k = m;
 bool flag = true;           // 标志找到一个有效组合
 while(order[0] == -1)
 {
  if(flag)                   // 输出符合要求的组合
  {
   for(i=1; i<=m; i++)
    cout << a[order[i]] << " ";
   cout << endl;
   count++;
   flag = false;
  }

  order[k]++;                // 在当前位置选择新的数字
  if(order[k] == n)          // 当前位置已无数字可选，回溯
  {
   order[k--] = 0;
   continue;
  }

  if(k < m)                  // 更新当前位置的下一位置的数字
  {
   order[++k] = order[k-1];
   continue;
  }

  if(k == m)
   flag = true;
 }

 delete[] order;
 return count;
}
--]==]

local function combine(n, m)

	m = m>n and n or m
	local order = {}
	for i=0, m do
		order[i]=i
	end

	local count = 0
	local k = m
	local flag = true
	while order[0]==0 do
		if flag==true then
			for i=1, m do
				io.write(order[i].."  ")
			end
			io.write("\n")
			count=count+1
			flag=false
		end

		order[k] = order[k]+1
		if order[k]==n+1 then
			order[k] = 1
			k = k-1
		else
			if k<m then
				k = k+1
				order[k]=order[k-1]

			elseif k == m then
				flag = true
			end
		end

	end

	return count
end
--combine( 4,2)

--print)




--[[
int combine(int n, int m)
{
	m = m > n ? n : m;

	vector<int> order;
	for(int i=0; i<=m; i++)
		order.push_back(i);				// 注意这里order[0]=-1用来作为循环判断标识

	int count = 0;
	int k = m;
	bool flag = true;						// 标志找到一个有效组合
	while(order[0] == 0)
	{

		if(flag)							// 输出符合要求的组合
		{
			count++;
			for(int i=1; i<=m; i++)
				cout << order[i] << " ";
			cout << endl;
			flag = false;
		}

		order[k]++;							// 在当前位置选择新的数字
		if(order[k] == n+1)					// 当前位置已无数字可选，回溯
		{
			order[k] = 1;
			k--;
			continue;
		}

		if(k < m)							// 更新当前位置的下一位置的数字
		{
			++k;
			order[k] = order[k-1];
			continue;
		}

		if(k == m)
			flag = true;
	}
	return count;
}
--]]


local function visit( order, tab, n)

	local  pos = 0
	for i=1, #order do
		--print(order, i,order[i],total)
		local num = order[i]-pos-1
		if num > 0 then
			io.write(string.rep("["..tab[i].."]", num))
		end
		pos = order[i]
	end
	if n>pos then
		io.write(string.rep("["..tab[#tab].."]", n-pos))
	end


	io.write("\n")
end

local function combine(card_tab, ting_count)
	m = #card_tab-1
	n = ting_count+m

	m = m>n and n or m
	local order = {}
	for i=0, m do
		order[i]=i
	end

	local count = 0
	local k = m
	local flag = true
	while order[0]==0 do
		if flag==true then
			--for i=1, m do
			--	io.write(order[i].."  ")
			--end
			--io.write("\n")
			visit(order, card_tab, n)

			count=count+1
			flag=false
		end

		order[k] = order[k]+1
		if order[k]==n+1 then
			order[k] = 1
			k = k-1
		else
			if k<m then
				k = k+1
				order[k]=order[k-1]

			elseif k == m then
				flag = true
			end
		end

	end

	return count
end
combine( {1,2,3,5,6,7,8,9,10,22,34,222,32222,33333332},5)
--print("ok")



local None=0
local ShunQ=1
local ShunZ=2
local ShunH=3
local Tuo =4
local MAXKan=5

local function _CheckShun(check, state, pos)
	local posnext, poslast
	local currvar = check[pos]
	local size = #check
	local print=function()end
	for iPos=pos+1, size do
		local cVar=check[iPos]
		print(iPos, cVar, currvar, size,pos)
		if cVar>currvar+1 then
			print("po3333snext")
			return false
		end
		if (state[iPos]==nil or state[iPos]==None) and cVar==currvar+1 then
			posnext = iPos
			break
		end
	end

	if posnext==nil then
		print("posnext")
		return false
	end

	for iPos=posnext+1, size do
		local cVar=check[iPos]
		if cVar>currvar+2 then
			print("po3333snex11111t")
			return false
		end
		if (state[iPos]==nil or state[iPos]==None) and cVar==currvar+2 then
			poslast = iPos
			break
		end
	end
	if poslast==nil then
		print("po3333snex11111t22222222")
		return false
	end
	print(pos, posnext, poslast, "----------------------->>>",shunZ)
	state[pos]=ShunQ
	state[posnext]=ShunZ
	state[poslast]=ShunH
	return true
end


local function _CheckTuo(check, state, pos)
	local posnext, poslast
	local currvar = check[pos]
	local size = #check
	local print = function()end

	for iPos=pos+1, size do
		local cVar=check[iPos]
		print(iPos, cVar, currvar,"======",state[iPos])
		if cVar>currvar then
			print("tuo111111111")
			return false
		end
		if (state[iPos]==nil or state[iPos]==None) and cVar==currvar then
			print("tuo111111111>>>>")
			posnext = iPos
			break
		end
	end

	if posnext==nil then
		print("tuo111111111222222222<<<<")
		return false
	end

	for iPos=posnext+1, size do
		local cVar=check[iPos]
		if cVar>currvar then
			print("tuo1111111112222222222211")
			return false
		end
		if (state[iPos]==nil or state[iPos]==None) and cVar==currvar then
			poslast = iPos
			break
		end
	end
	if poslast==nil then
		print("tuo1111111112222222223333")
		return false
	end

	state[pos]=Tuo
	state[posnext]=Tuo
	state[poslast]=Tuo
	return true
end


local function UnState(check, state, pos, cS)
	local t_state = state[pos]
	local t_pai   = check[pos]
	local size  = #check

	if t_state==ShunQ then
		local  pos2, pos3
		for i=pos+1, size do
			if check[i]==t_pai+1 and state[i]==ShunZ then
				pos2 = i
				break
			end
		end
		if pos2 == nil then
			print("+++111111EEEEE")
		end

		for i=pos2+1, size do
			if check[i]==t_pai+2 and state[i]==ShunH then
				pos3=i
				break
			end
		end
		if pos3 == nil then
			print("---1111111EEEEE")
		end

		state[pos2]=nil
		state[pos3]=nil
		if cS then  state[pos]=nil end
	elseif t_state==Tuo then
		local  pos2, pos3
		for i=pos+1, size do
			if check[i]==t_pai and state[i]==Tuo then
				pos2 = i
				break
			end
		end
		if pos2 == nil then
			print("+++222222EEEEE")
		end

		for i=pos2+1, size do
			if check[i]==t_pai and state[i]==Tuo then
				pos3=i
				break
			end
		end
		if pos3 == nil then
			print("---222222EEEEE")
		end

		state[pos2]=nil
		state[pos3]=nil
		if cS then  state[pos]=nil end
	else
		print("+++EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE")
	end

end

function nextPos(check, state, pos)
	for ipos=pos+1, #check do
		if state[ipos]== nil or state[ipos]==0 then
			return ipos
		end
	end
end

function checkKan1(check)
	local t = {}
	if #check%3~=0 then
		return false
	end

	--local print = function()end
	local state={}
	local pos = 0
	while true do
		pos = nextPos(check, state, pos)
		if pos == nil then return true end
		if false==_CheckTuo(check, state, pos) and false==_CheckShun(check, state, pos) then
			return false
		end
	end
	return true
end


function checkKan(check)
	local t = {}
	if #check%3~=0 then
		return false
	end

	local print = function()end


	local state={}
	local pos = 1
	local try = {}
	while true do
		local curstate=state[pos] or None
		if curstate== None then
			if _CheckShun(check, state, pos) then
				try[#try+1]=pos
				pos = nextPos(check, state, pos)

			elseif _CheckTuo(check, state, pos) then
				try[#try+1]=pos
				pos = nextPos(check, state, pos)
			else
				if #try>0 then
					pos=try[#try]
					table.remove(try, #try)
				else
					return false
				end
			end
		elseif curstate == Tuo then
			if #try>0 then
				UnState(check, state, pos, true)
				pos = try[#try]
				table.remove(try, #try)
			else
				return false
			end
		elseif curstate == ShunQ then
			UnState(check, state, pos, true)
			if _CheckTuo(check, state, pos) then
				try[#try+1]=pos
				pos = nextPos(check, state, pos)
			else
				if #try>0 then
					pos = try[#try]
					table.remove(try, #try)
				else
					return false
				end
			end
		else
			print("unexpected")
		end

		if pos == nil then
			return true
		end
	end

	return true
end

local t = {1,1,2,2,2,2,2,2,2,3,3,4,4,5,5,5,5,6}

--print(checkKan(t))
--print(checkKan1(t))


function DaDuiZi(sp)
	local point=0
	local count=0
	local jNum = 0
	for i=1, #sp do
		if sp[i]==point then
			count=count+1
		else
			local exvar = count%3
			if exvar==1 then
				return false
			elseif exvar==2 then
				jNum = jNum+1
				if jNum>1 then return false end
			end

			point=sp[i]
			count=1
		end
	end

	local exvar = count%3
	if exvar==1 then
		return false
	elseif exvar==2 then
		jNum = jNum+1
		if jNum>1 then return false end
	end

	return true
end

local t1={1,1,1,2,2,2,3,3}
print(DaDuiZi(t1))

