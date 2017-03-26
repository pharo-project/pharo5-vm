inline primitive register allocation
allocateRegistersForLowcodeOop: aBlock
	<option: #LowcodeVM>
	<inline: true>
	
	| rOopTop  |
	rOopTop := NoReg.

	self ssTop registerOrNone ~= NoReg ifTrue:  [
		rOopTop := self ssTop registerOrNone.
		"Ensure we are not using a duplicated register."
		(self isOopRegister: rOopTop usedBefore: 0) ifTrue: [
			rOopTop := NoReg
		]
	].

	rOopTop = NoReg ifTrue: [
		rOopTop := self allocateRegNotConflictingWith: (self emptyRegisterMask)
	].

	self deny: (rOopTop = NoReg).
	^ aBlock value: rOopTop
	