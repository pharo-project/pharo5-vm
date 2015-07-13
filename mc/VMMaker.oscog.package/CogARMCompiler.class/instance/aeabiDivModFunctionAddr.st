ARM convenience instructions
aeabiDivModFunctionAddr
"return the address of the __aeabi_idivmod() call provided by the ARM low level libs to do an integer divide that returns the quo in R0 and rem in R1"
	<returnTypeC: #usqInt>
	^self cCode: '(usqInt)__aeabi_idivmod' inSmalltalk:[#aeabiDiv:Mod:]