inline primitive register allocation
allocateRegistersForLowcodeResultInteger2: aBlock
	<option: #LowcodeVM>
	<inline: true>

	| rResult rResult2 |
	rResult := rResult2 := NoReg.

	"Float result".
	rResult := self allocateRegNotConflictingWith: (self emptyRegisterMask).
	rResult2 := self allocateRegNotConflictingWith: (self registerMaskFor: rResult).
	self deny: (rResult = NoReg or: [rResult2 = NoReg]).

	^ aBlock value: rResult value: rResult2
