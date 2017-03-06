inline primitive register allocation
allocateRegistersForLowcodeIntegerOop2: aBlock
	<option: #LowcodeVM>
	<inline: true>
	
	| rTop rOopTop rOopNext topRegisterMask oopTopRegisterMask |
	rTop := rOopTop := rOopNext := NoReg.
	oopTopRegisterMask := topRegisterMask := 0.

	self ssNativeTop nativeRegisterOrNone ~= NoReg ifTrue:  [
		rTop := self ssNativeTop nativeRegisterOrNone.
		oopTopRegisterMask := self registerMaskFor: rTop.
	].

	self ssTop registerOrNone ~= NoReg ifTrue:  [
		rOopTop := self ssTop registerOrNone.
		topRegisterMask := self registerMaskFor: rOopTop.
	].

	(self ssValue: 1) registerOrNone ~= NoReg ifTrue: [
		rOopNext := (self ssValue: 1) registerOrNone.
		topRegisterMask := topRegisterMask bitOr: (self registerMaskFor: rOopNext).
		oopTopRegisterMask := oopTopRegisterMask bitOr: (self registerMaskFor: rOopNext).
	].

	rTop = NoReg ifTrue: [
		rTop := self allocateRegNotConflictingWith: topRegisterMask
	].

	rOopTop = NoReg ifTrue: [
		rOopTop := self allocateRegNotConflictingWith: oopTopRegisterMask
	].

	rOopNext = NoReg ifTrue: [
		rOopNext := self allocateRegNotConflictingWith: (self registerMaskFor: rTop and: rOopTop)
	].

	self deny: (rTop = NoReg or: [rOopTop = NoReg or: [rOopNext = NoReg]]).
	^ aBlock value: rTop value: rOopTop value: rOopNext
	