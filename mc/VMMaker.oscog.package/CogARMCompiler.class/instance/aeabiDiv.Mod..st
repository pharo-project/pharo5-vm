simulation
aeabiDiv: dividend Mod: divisor
"simulate the __aeabi_idivmod call"
	<doNotGenerate>
	| proc result top bottom|
	proc := cogit processor.
	top := proc convertInternalToInteger: dividend.
	bottom := proc convertInternalToInteger: divisor.
	
	proc r0: (result := proc convertIntegerToInternal: (top quo: bottom)).
	proc r1: (proc convertIntegerToInternal: (top rem: bottom)).
	^result