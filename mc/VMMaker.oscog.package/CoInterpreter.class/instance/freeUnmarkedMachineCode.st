object memory support
freeUnmarkedMachineCode
	"Free machine-code methods whose compiled methods are unmarked
	 (or open PICs whose selectors are not marked).
	 The stack pages have already been traced so any methods
	 of live stack activations have already been marked and traced."
	<doNotGenerate>
	cogit freeUnmarkedMachineCode