inline primitive register allocation
allocateRegistersForLowcodeOopResultFloat: aBlock
	<option: #LowcodeVM>
	<inline: true>
	
	| rOopTop  frResult |
	rOopTop := NoReg.
	frResult := NoReg.

	self ssTop registerOrNone ~= NoReg ifTrue:  [
		rOopTop := self ssTop registerOrNone.
	].

	rOopTop = NoReg ifTrue: [
		rOopTop := self allocateRegNotConflictingWith: (self emptyRegisterMask)
	].

	frResult := self allocateFloatRegNotConflictingWith: (self emptyRegisterMask).

	self deny: (rOopTop = NoReg or: [frResult = NoReg]).
	^ aBlock value: rOopTop value: frResult
	