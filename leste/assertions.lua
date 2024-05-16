local Assertions = {}

Assertions.assert = function(condition, message)
	message = message and
		message or
		"Assertion failed: Expected condition to be true, but it's false."

	assert(condition, message)
end

Assertions.notAssert = function(condition, message)
	message = message and
		message or
		"Assertion failed: Expected condition to be false, but it's true."

	assert(not condition, message)
end

Assertions.equal = function(expected, actual, message)
	message = message and
		message or
		("Assertion failed: %s is not equal %s."):
		format(tostring(expected), tostring(actual))

	assert(expected == actual, message)
end

Assertions.notEqual = function(expected, actual, message)
	message = message and
		message or
		("Assertion failed: %s is equal %s."):
		format(tostring(expected), tostring(actual))

	assert(expected ~= actual, message)
end

Assertions.tableHasKey = function(tbl, key, message)
	message = message and
		message or
		("Assertion failed: The table does not contain the key '%s'."):
		format(tostring(key))

	assert(tbl[key] ~= nil, message)
end

Assertions.tableNotHasKey = function(tbl, key, message)
	message = message and
		message or
		("Assertion failed: The table contains the key '%s'."):
		format(tostring(key))

	assert(tbl[key] == nil, message)
end

Assertions.tableContains = function(tbl, value, message)
	message = message and
		message or
		("Assertion failed: The table does not have the value '%s'."):
		format(tostring(value))

	local hasValue = false
	for _, v in pairs(tbl) do
		if v == value then
			hasValue = true
			break
		end
	end

	assert(hasValue, message)
end

Assertions.tableNotContains = function(tbl, value, message)
	message = message and
		message or
		("Assertion failed: The table contains the value '%s'."):
		format(tostring(value))

	local hasValue = false
	for _, v in pairs(tbl) do
		if v == value then
			hasValue = true
			break
		end
	end

	assert(not hasValue, message)
end

return Assertions
