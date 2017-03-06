inline primitive register allocation
allocateRegistersForLowcodeInteger: aBlock
	<option: #LowcodeVM>
	<inline: true>
	
	| rTop |
	rTop := NoReg.

	self ssNativeTop nativeRegisterOrNone ~= NoReg ifTrue:  [
		rTop := self ssNativeTop nativeRegisterOrNone.
	].

	rTop = NoReg ifTrue:
		[ rTop := self allocateRegNotConflictingWith: self emptyRegisterMask].

	self deny: (rTop = NoReg).
	^ aBlock value: rTop
	