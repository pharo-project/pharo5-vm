inline primitive register allocation
allocateRegistersForLowcodeOopResultInteger2: aBlock
	<option: #LowcodeVM>
	<inline: true>
	
	| rOopTop rResult rResult2 |
	rOopTop := NoReg.
	rResult := rResult2 := NoReg.

	self ssTop registerOrNone ~= NoReg ifTrue:  [
		rOopTop := self ssTop registerOrNone.
	].

	rOopTop = NoReg ifTrue: [
		rOopTop := self allocateRegNotConflictingWith: (self emptyRegisterMask)
	].

	rResult := self allocateRegNotConflictingWith: (self registerMaskFor: rOopTop).
	rResult2 := self allocateRegNotConflictingWith: (self registerMaskFor: rOopTop and: rResult).

	self deny: (rOopTop = NoReg or: [rResult = NoReg]).
	^ aBlock value: rOopTop value: rResult value: rResult2
	