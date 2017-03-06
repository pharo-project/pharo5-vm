inline primitive register allocation
allocateRegistersForLowcodeIntegerResultInteger2: aBlock
	<option: #LowcodeVM>
	<inline: true>
	
	| rTop rResult rResult2 |
	rTop := NoReg.
	rResult := rResult := NoReg

	self ssNativeTop nativeRegisterOrNone ~= NoReg ifTrue:  [
		rTop := self ssNativeTop nativeRegisterOrNone.
	].

	rTop = NoReg ifTrue:
		[ rTop := self allocateRegNotConflictingWith: self emptyRegisterMask].
	
	rResult := self allocateRegNotConflictingWith: (self registerMaskFor: rTop).
	rResult2 := self allocateRegNotConflictingWith: (self registerMaskFor: rTop and: rResult).

	self deny: (rTop = NoReg or: [rResult = NoReg or: [rResult2 = NoReg]]).
	^ aBlock value: rTop value: rResult value: rResult2
	