method map
mcPCFor: bcpc startBcpc: startbcpc in: cogMethod
	"Answer the absolute machine code pc matching the zero-relative bytecode pc argument
	 in cogMethod, given the start of the bytecodes for cogMethod's block or method object."
	<api>
	<var: #cogMethod type: #'CogBlockMethod *'>
	| absPC |
	absPC := self
				mapFor: cogMethod
				bcpc: startbcpc
				performUntil: #find:Mcpc:Bcpc:MatchingBcpc:
				arg: (self cCoerceSimple: bcpc to: #'void *').
	^absPC ~= 0
		ifTrue: [absPC asUnsignedInteger - cogMethod asUnsignedInteger]
		ifFalse: [absPC]