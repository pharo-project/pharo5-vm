inline primitive register allocation
allocateRegistersForLowcodeResultInteger: aBlock
	<option: #LowcodeVM>
	<inline: true>

	| rResult |
	rResult := NoReg.

	"Float result".
	rResult := self allocateRegNotConflictingWith: (self emptyRegisterMask).
	self deny: (rResult = NoReg).

	^ aBlock value: rResult
