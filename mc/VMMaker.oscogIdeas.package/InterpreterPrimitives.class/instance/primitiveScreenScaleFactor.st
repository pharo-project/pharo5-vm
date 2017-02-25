I/O primitives
primitiveScreenScaleFactor
	"Answer a float indicating the current scale factor for pixels of the Smalltalk window."
	| factor |
	<export: true>
	<var: #factor type: #double>
	factor := self ioScreenScaleFactor.
	self failed ifTrue:[^self primitiveFail].
	self pop: 1; pushFloat: factor.