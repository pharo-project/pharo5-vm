simulation
aeabiDiv: dividend Mod: divisor
"simulate the __aeabi_idivmod call"
	<doNotGenerate>
	|result top bottom|

	top:= dividend signedIntFromLong.
	bottom := divisor signedIntFromLong.
	
	cogit processor r0: (result :=(top quo: bottom) signedIntToLong).
	cogit processor r1: (top rem: bottom) signedIntToLong.
	^result