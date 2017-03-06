inline primitive register allocation
allocateRegistersForLowcodeFloat2ResultInteger: aBlock
	<option: #LowcodeVM>
	<inline: true>

	| frNext frTop topRegistersMask rResult |
	topRegistersMask := 0.
	frTop := frNext := NoReg.
	rResult := NoReg.

	self ssNativeTop  nativeFloatRegisterOrNone ~= NoReg ifTrue: 
		[ frTop := self ssNativeTop nativeFloatRegisterOrNone].
	(self ssNativeValue: 1)  nativeFloatRegisterOrNone ~= NoReg ifTrue: 
		[ topRegistersMask := self registerMaskFor: (frNext := (self ssNativeValue: 1) nativeFloatRegisterOrNone)].
	
	frTop = NoReg ifTrue:
		[ frTop := self allocateFloatRegNotConflictingWith: topRegistersMask ].
	
	frNext = NoReg ifTrue:
		[ frNext := self allocateFloatRegNotConflictingWith: (self registerMaskFor: frTop) ].
	
	"Result"
	rResult := self allocateRegNotConflictingWith: 0.

	self deny: (frTop = NoReg or: [frNext = NoReg or: [rResult]]).

	^ aBlock value: frTop value: frNext value: rResult
