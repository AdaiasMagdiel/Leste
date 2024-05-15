local Assertions = {}

Assertions.assert = function(expr, message)
	message = message and message or "Assertion failed: Expected condition to be true, but it's false."
	assert(expr, message)
end

return Assertions
