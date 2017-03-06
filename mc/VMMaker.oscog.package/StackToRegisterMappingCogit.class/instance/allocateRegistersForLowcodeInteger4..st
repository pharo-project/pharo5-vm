inline primitive register allocation
allocateRegistersForLowcodeInteger4: aBlock
	<option: #LowcodeVM>
	<inline: true>
	
	| rNext rNextNext rNextNextNext nativeValueIndex rTop registerMask |
	rTop := rNext := rNextNext := rNextNextNext := NoReg.
	nativeValueIndex := 1.

	self ssNativeTop nativeRegisterOrNone ~= NoReg ifTrue:  [
		rTop := self ssNativeTop nativeRegisterOrNone.
		self ssNativeTop nativeRegisterSecondOrNone ~= NoReg ifTrue:
			[ rNext := self ssNativeTop nativeRegisterSecondOrNone]
	].

	rNext = NoReg ifTrue: [
		(self ssNativeValue: nativeValueIndex)  nativeRegisterOrNone ~= NoReg ifTrue:  [
			rNext := (self ssNativeValue: nativeValueIndex) nativeRegisterOrNone.
			(self ssNativeValue: nativeValueIndex) nativeRegisterSecondOrNone ~= NoReg ifTrue: [
				rNextNext := (self ssNativeValue: nativeValueIndex) nativeRegisterOrNone.
			].
			nativeValueIndex := nativeValueIndex + 1
		].
	].

	rNextNext = NoReg ifTrue: [
		(self ssNativeValue: nativeValueIndex)  nativeRegisterOrNone ~= NoReg ifTrue:  [
			rNextNext := (self ssNativeValue: nativeValueIndex) nativeRegisterOrNone.
			(self ssNativeValue: nativeValueIndex) nativeRegisterSecondOrNone ~= NoReg ifTrue: [
				rNextNextNext := (self ssNativeValue: nativeValueIndex) nativeRegisterSecondOrNone.
			].
			nativeValueIndex := nativeValueIndex + 1
		].
	].

	rNextNextNext = NoReg ifTrue: [
		(self ssNativeValue: nativeValueIndex)  nativeRegisterOrNone ~= NoReg ifTrue:  [
			rNextNextNext := (self ssNativeValue: nativeValueIndex) nativeRegisterOrNone.
			nativeValueIndex := nativeValueIndex + 1
		].
	].

	rTop = NoReg ifTrue: [
		registerMask := 0.
		rNext ~= NoReg ifTrue: [ registerMask := self registerMaskFor: rNext].
		rNextNext ~= NoReg ifTrue: [ registerMask := registerMask bitOr: (self registerMaskFor: rNextNext)].
		rNextNextNext ~= NoReg ifTrue: [ registerMask := registerMask bitOr: (self registerMaskFor: rNextNextNext)].
		rTop := self allocateRegNotConflictingWith: registerMask
	].
	
	rNext = NoReg ifTrue: [
		registerMask := self registerMaskFor: rTop.
		rNextNext ~= NoReg ifTrue: [ registerMask := registerMask bitOr: (self registerMaskFor: rNextNext)].
		rNextNextNext ~= NoReg ifTrue: [ registerMask := registerMask bitOr: (self registerMaskFor: rNextNextNext)].
		rNext := self allocateRegNotConflictingWith: registerMask
	].

	rNextNext = NoReg ifTrue: [
		registerMask := self registerMaskFor: rTop and: rNext.
		rNextNextNext ~= NoReg ifTrue: [ registerMask := registerMask bitOr: (self registerMaskFor: rNextNextNext)].
		rNextNext := self allocateRegNotConflictingWith: registerMask
	].

	rNextNextNext = NoReg ifTrue: [
		registerMask := self registerMaskFor: rTop and: rNext and: rNextNext.
		rNextNextNext := self allocateRegNotConflictingWith: registerMask
	].

	self deny: (rTop = NoReg or: [rNext = NoReg or: [rNextNext = NoReg or: [rNextNextNext = NoReg]]]).
	^ aBlock value: rTop value: rNext value: rNextNext value: rNextNextNext
	