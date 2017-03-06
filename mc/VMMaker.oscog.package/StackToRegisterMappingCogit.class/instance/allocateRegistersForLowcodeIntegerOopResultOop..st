inline primitive register allocation
allocateRegistersForLowcodeIntegerOopResultOop: aBlock
	<option: #LowcodeVM>
	<inline: true>
	
	| rTop rOopTop rOopResult topRegisterMask |
	rTop := rOopTop:= NoReg.
	rOopResult := NoReg.
	topRegisterMask := 0.

	self ssNativeTop nativeRegisterOrNone ~= NoReg ifTrue:  [
		rTop := self ssNativeTop nativeRegisterOrNone.
	].

	self ssTop registerOrNone ~= NoReg ifTrue:  [
		rOopTop := self ssTop registerOrNone.
		topRegisterMask := self registerMaskFor: rOopTop.
	].

	rTop = NoReg ifTrue: [
		rTop := self allocateRegNotConflictingWith: topRegisterMask
	].

	rOopTop = NoReg ifTrue: [
		rOopTop := self allocateRegNotConflictingWith: (self registerMaskFor: rTop)
	].

	rOopResult := self allocateRegNotConflictingWith: (self registerMaskFor: rTop and: rOopTop).

	self deny: (rTop = NoReg or: [rOopTop = NoReg or: [rOopResult = NoReg]]).
	
	^ aBlock value: rTop value: rOopTop value: rOopResult
