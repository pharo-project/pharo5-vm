inline primitive register allocation
allocateRegistersForLowcodeFloat: aBlock
	<option: #LowcodeVM>
	<inline: true>

	| frTop topRegistersMask |
	topRegistersMask := 0.
	frTop := NoReg.

	self ssNativeTop nativeFloatRegisterOrNone ~= NoReg ifTrue: 
		[ frTop := self ssNativeTop nativeFloatRegisterOrNone].
	
	frTop = NoReg ifTrue:
		[ frTop := self allocateFloatRegNotConflictingWith: topRegistersMask ].
	self deny: (frTop = NoReg).

	^ aBlock value: frTop
