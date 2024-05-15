local Assertions = {}

Assertions.assert = function(condition, message)
	message = message and message or "Assertion failed: Expected condition to be true, but it's false."
	assert(condition, message)
end

return Assertions
