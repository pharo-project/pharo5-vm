inline primitive register allocation
allocateRegistersForLowcodeOop2ResultInteger: aBlock
	<option: #LowcodeVM>
	<inline: true>
	
	| rOopTop rOopNext rResult oopTopRegisterMask |
	rOopTop := rOopNext := NoReg.
	rResult := NoReg.
	oopTopRegisterMask := 0.

	self ssTop registerOrNone ~= NoReg ifTrue:  [
		rOopTop := self ssTop registerOrNone.
	].

	(self ssValue: 1) registerOrNone ~= NoReg ifTrue: [
		rOopNext := (self ssValue: 1) registerOrNone.
		oopTopRegisterMask := self registerMaskFor: rOopNext.
	].

	rOopTop = NoReg ifTrue: [
		rOopTop := self allocateRegNotConflictingWith: oopTopRegisterMask
	].

	rOopNext = NoReg ifTrue: [
		rOopNext := self allocateRegNotConflictingWith: (self registerMaskFor: rOopTop)
	].

	rResult := self allocateRegNotConflictingWith: (self registerMaskFor: rOopTop and: rOopNext).
	
	self deny: (rOopTop = NoReg or: [rOopNext = NoReg or: [rResult = NoReg]]).
	^ aBlock value: rOopTop value: rOopNext value: rResult
	