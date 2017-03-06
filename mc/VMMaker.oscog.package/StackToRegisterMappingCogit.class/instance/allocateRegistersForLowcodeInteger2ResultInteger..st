inline primitive register allocation
allocateRegistersForLowcodeInteger2ResultInteger: aBlock
	<option: #LowcodeVM>
	<inline: true>
	
	| rNext rTop topRegistersMask rResult |
	topRegistersMask := 0.
	rTop := rNext := NoReg.
	rResult := NoReg

	self ssNativeTop nativeRegisterOrNone ~= NoReg ifTrue:  [
		rTop := self ssNativeTop nativeRegisterOrNone.
		self ssNativeTop nativeRegisterSecondOrNone ~= NoReg ifTrue:
			[ rNext := self ssNativeTop nativeRegisterSecondOrNone]
	].

	rNext = NoReg ifTrue: [
		(self ssNativeValue: 1)  nativeRegisterOrNone ~= NoReg ifTrue: 
			[ topRegistersMask := self registerMaskFor: (rNext := (self ssNativeValue: 1) nativeRegisterOrNone)].
	].

	rTop = NoReg ifTrue:
		[ rTop := self allocateRegNotConflictingWith: topRegistersMask ].
	
	rNext = NoReg ifTrue:
		[ rNext := self allocateRegNotConflictingWith: (self registerMaskFor: rTop) ].

	self deny: (rTop = NoReg or: [rNext = NoReg]).

	"Results"
	rResult := self allocateFloatRegNotConflictingWith: (self registerMaskFor: rTop and: rNext).
	self deny: (rResult = NoReg).
	
	^ aBlock value: rTop value: rNext value: rResult