inline primitive register allocation
allocateRegistersForLowcodeOop2: aBlock
	<option: #LowcodeVM>
	<inline: true>
	
	| rOopTop rOopNext oopTopRegisterMask |
	rOopTop := rOopNext := NoReg.
	oopTopRegisterMask := 0.

	self ssTop registerOrNone ~= NoReg ifTrue:  [
		rOopTop := self ssTop registerOrNone.
		"Ensure we are not using a duplicated register."
		(self isOopRegister: rOopTop usedBefore: 0) ifTrue: [
			rOopTop := NoReg
		]
	].

	(self ssValue: 1) registerOrNone ~= NoReg ifTrue: [
		rOopNext := (self ssValue: 1) registerOrNone.
		"Ensure we are not using a duplicated register."
		(self isOopRegister: rOopNext usedBefore: 1) ifTrue: [
			rOopNext := NoReg
		].
		rOopNext ~= NoReg ifTrue: [ 
			oopTopRegisterMask := self registerMaskFor: rOopNext.
		].
	].

	rOopTop = NoReg ifTrue: [
		rOopTop := self allocateRegNotConflictingWith: oopTopRegisterMask
	].

	rOopNext = NoReg ifTrue: [
		rOopNext := self allocateRegNotConflictingWith: (self registerMaskFor: rOopTop)
	].

	self deny: (rOopTop = NoReg or: [rOopNext = NoReg ]).
	^ aBlock value: rOopTop value: rOopNext
	