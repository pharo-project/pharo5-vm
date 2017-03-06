inline primitive register allocation
allocateRegistersForLowcodeInteger2ResultFloat: aBlock
	<option: #LowcodeVM>
	<inline: true>
	
	| rNext rTop topRegistersMask frResult |
	topRegistersMask := 0.
	rTop := rNext := NoReg.
	frResult := NoReg

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

	"Results"
	frResult := self allocateFloatRegNotConflictingWith: self emptyRegisterMask.
	
	self deny: (rTop = NoReg or: [rNext = NoReg or: [frResult = NoReg]]).
	
	^ aBlock value: rTop value: rNext value: frResult