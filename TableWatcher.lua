local TestTable = { };

local function watch(tabWatching, callback)
	local _main = { };

	setmetatable(tabWatching, {
		__index = function(self, key)
            -- Access key
			return _main[key];
		end,

		__newindex = function(self, key, value)
			-- Capture the old value
			local old_value = rawget(self, key);
			
            -- Set callback
			callback(key, value);

            -- Update old value
			_main[key] = value;
		end,
	});
end

-- Watcher function with a callback of key, test (need to include old value later)
watch(TestTable, function(key, value)
	print(key, value);
end)

-- Test table index 5 with a table of "test" with a table of "test2" with a value of true.
TestTable["5"] = {
	test = {
		test2 = true
	}
};

-- Test table index 5 with a table of "test" with a table of "test2" with a value of false.
TestTable["5"] = {
	test = {
		test2 = false
	}
};