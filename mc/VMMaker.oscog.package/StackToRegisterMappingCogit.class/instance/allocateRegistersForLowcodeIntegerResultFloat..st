inline primitive register allocation
allocateRegistersForLowcodeIntegerResultFloat: aBlock
	<option: #LowcodeVM>
	<inline: true>
	
	| rTop frResult|
	rTop := NoReg.
	frResult := NoReg

	self ssNativeTop nativeRegisterOrNone ~= NoReg ifTrue:  [
		rTop := self ssNativeTop nativeRegisterOrNone.
	].

	rTop = NoReg ifTrue:
		[ rTop := self allocateRegNotConflictingWith: self emptyRegisterMask].
	
	frResult := self allocateFloatRegNotConflictingWith: self emptyRegisterMask.

	self deny: (rTop = NoReg or: [frResult = NoReg]).
	^ aBlock value: rTop value: frResult
	