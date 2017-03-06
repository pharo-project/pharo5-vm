inline primitive register allocation
allocateRegistersForLowcodeOopResultOop: aBlock
	<option: #LowcodeVM>
	<inline: true>
	
	| rOopTop rResult |
	rOopTop := NoReg.
	rResult := NoReg.

	self ssTop registerOrNone ~= NoReg ifTrue:  [
		rOopTop := self ssTop registerOrNone.
	].

	rOopTop = NoReg ifTrue: [
		rOopTop := self allocateRegNotConflictingWith: (self emptyRegisterMask)
	].

	rResult := self allocateRegNotConflictingWith: (self registerMaskFor: rOopTop).

	self deny: (rOopTop = NoReg or: [rResult = NoReg]).
	^ aBlock value: rOopTop value: rResult
	