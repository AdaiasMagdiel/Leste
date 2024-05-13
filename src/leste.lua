local Leste = {
	tests = {}
}

Leste.it = function(describe, test)
	Leste.tests[describe] = test
end

Leste.run = function()
	for describe, test in pairs(Leste.tests) do
		print(describe)
		test()
	end
end

return Leste
