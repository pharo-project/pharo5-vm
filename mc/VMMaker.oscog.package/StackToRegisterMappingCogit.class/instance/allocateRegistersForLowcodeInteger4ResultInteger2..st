inline primitive register allocation
allocateRegistersForLowcodeInteger4ResultInteger2: aBlock
	<option: #LowcodeVM>
	<inline: true>
	
	| rNext rNextNext rNextNextNext nativeValueIndex rTop nextRegisterMask rResult rResult2 |
	rTop := rNext := rNextNext := rNextNextNext := NoReg.
	rResult := rResult2 := NoReg.
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
		nextRegisterMask := 0.
		rNext ~= NoReg ifTrue: [ nextRegisterMask := self registerMaskFor: rNext].
		rNextNext ~= NoReg ifTrue: [ nextRegisterMask := nextRegisterMask bitOr: (self registerMaskFor: rNextNext)].
		rNextNextNext ~= NoReg ifTrue: [ nextRegisterMask := nextRegisterMask bitOr: (self registerMaskFor: rNextNextNext)].
		rTop := self allocateRegNotConflictingWith: nextRegisterMask
	].
	
	rNext = NoReg ifTrue: [
		nextRegisterMask := self registerMaskFor: rTop.
		rNextNext ~= NoReg ifTrue: [ nextRegisterMask := nextRegisterMask bitOr: (self registerMaskFor: rNextNext)].
		rNextNextNext ~= NoReg ifTrue: [ nextRegisterMask := nextRegisterMask bitOr: (self registerMaskFor: rNextNextNext)].
		rNext := self allocateRegNotConflictingWith: nextRegisterMask
	].

	rNextNext = NoReg ifTrue: [
		nextRegisterMask := self registerMaskFor: rTop and: rNext.
		rNextNextNext ~= NoReg ifTrue: [ nextRegisterMask := nextRegisterMask bitOr: (self registerMaskFor: rNextNextNext)].
		rNextNext := self allocateRegNotConflictingWith: nextRegisterMask
	].

	rNextNextNext = NoReg ifTrue: [
		nextRegisterMask := self registerMaskFor: rTop and: rNext and: rNextNext.
		rNextNextNext := self allocateRegNotConflictingWith: nextRegisterMask
	].

	self deny: (rTop = NoReg or: [rNext = NoReg or: [rNextNext = NoReg or: [rNextNextNext = NoReg]]]).
	
	"Result registers"
	rResult := self allocateRegNotConflictingWith: (self registerMaskFor: rTop and: rNext and: rNextNext and: rNextNextNext).
	rResult2 := self allocateRegNotConflictingWith: (self registerMaskFor: rTop and: rNext and: rNextNext and: rNextNextNext and: rResult).
	
	^ aBlock value: rTop value: rNext value: rNextNext value: rNextNextNext value: rResult value: rResult2
