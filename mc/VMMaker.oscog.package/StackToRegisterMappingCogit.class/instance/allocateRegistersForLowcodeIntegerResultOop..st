inline primitive register allocation
allocateRegistersForLowcodeIntegerResultOop: aBlock
	<option: #LowcodeVM>
	<inline: true>
	
	| rTop rResult|
	rTop := NoReg.
	rResult := NoReg

	self ssNativeTop nativeRegisterOrNone ~= NoReg ifTrue:  [
		rTop := self ssNativeTop nativeRegisterOrNone.
	].

	rTop = NoReg ifTrue:
		[ rTop := self allocateRegNotConflictingWith: self emptyRegisterMask].
	
	rResult := self allocateRegNotConflictingWith: (self registerMaskFor: rTop).

	self deny: (rTop = NoReg or: [rResult = NoReg]).
	^ aBlock value: rTop value: rResult
	