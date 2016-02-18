ARM convenience instructions
aeabiDivModFunctionAddr
"return the address of the __aeabi_idivmod() call provided by the ARM low level libs to do an integer divide that returns the quo in R0 and rem in R1.
A word on the somewhat strange usage of idivmod herein; we need a declaration for the _aeabi_idivmod helper function, despite the fact that in a simple C program test, you don't. To get that declaration we need a variable to hang it off and said variable needs to be referred to in order to not get culled. Thus the temp var idivmod, the declaration for it that has nothing to do with it and the odd usage in the inSmalltalk: block."
	| idivmod |
	<returnTypeC: #usqInt>
	<var: #idivmod declareC: 'extern void __aeabi_idivmod(int dividend, int divisor)'>

	^self cCode: '(usqInt)__aeabi_idivmod' inSmalltalk:[idivmod := #aeabiDiv:Mod:]