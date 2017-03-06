inline primitive register allocation
allocateRegistersForLowcodeResultFloat: aBlock
	<option: #LowcodeVM>
	<inline: true>

	| frResult |
	frResult := NoReg.

	"Float result".
	frResult := self allocateFloatRegNotConflictingWith: (self emptyRegisterMask).
	self deny: (frResult = NoReg).

	^ aBlock value: frResult
