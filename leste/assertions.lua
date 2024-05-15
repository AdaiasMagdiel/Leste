local Assertions = {}

Assertions.assert = function(condition, message)
	message = message and
		message or
		"Assertion failed: Expected condition to be true, but it's false."

	assert(condition, message)
end

Assertions.equal = function(value1, value2, message)
	message = message and
		message or
		("Assertion failed: %s is not equal %s."):
		format(tostring(value1), tostring(value2))

	assert(value1 == value2, message)
end

return Assertions
