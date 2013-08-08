method map
mapStartFor: cogMethod
	"Answer the address of the first byte of the method map."
	<var: #cogMethod type: #'CogMethod *'>
	<inline: true>
	^cogMethod asUnsignedInteger + cogMethod blockSize - 1