inline primitive register allocation
allocateRegistersForLowcodeFloat2: aBlock
	<option: #LowcodeVM>
	<inline: true>

	| rNext rTop topRegistersMask |
	topRegistersMask := 0.
	rTop := rNext := NoReg.

	self ssNativeTop  nativeFloatRegisterOrNone ~= NoReg ifTrue: 
		[ rTop := self ssNativeTop nativeFloatRegisterOrNone].
	(self ssNativeValue: 1)  nativeFloatRegisterOrNone ~= NoReg ifTrue: 
		[ topRegistersMask := self registerMaskFor: (rNext := (self ssNativeValue: 1) nativeFloatRegisterOrNone)].
	
	rTop = NoReg ifTrue:
		[ rTop := self allocateFloatRegNotConflictingWith: topRegistersMask ].
	
	rNext = NoReg ifTrue:
		[ rNext := self allocateFloatRegNotConflictingWith: (self registerMaskFor: rTop) ].
	self deny: (rTop = NoReg or: [rNext = NoReg]).

	^ aBlock value: rTop value: rNext
