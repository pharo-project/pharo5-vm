simulation
aeabiDiv: dividend Mod: divisor
"simulate the __aeabi_idivmod call"
	<doNotGenerate>
	|result|

	cogit processor r0: (result :=dividend quo: divisor).
	cogit processor r1: (dividend rem: divisor).
	^result