inline primitive register allocation
allocateRegistersForLowcodeIntegerOop: aBlock
	<option: #LowcodeVM>
	<inline: true>
	
	| rTop rOopTop topRegisterMask |
	rTop := rOopTop := NoReg.
	topRegisterMask := 0.

	self ssNativeTop nativeRegisterOrNone ~= NoReg ifTrue:  [
		rTop := self ssNativeTop nativeRegisterOrNone.
	].

	self ssTop registerOrNone ~= NoReg ifTrue:  [
		rOopTop := self ssTop registerOrNone.
		topRegisterMask := self registerMaskFor: rOopTop.
	].

	rTop = NoReg ifTrue: [
		rTop := self allocateRegNotConflictingWith: topRegisterMask
	].

	rOopTop = NoReg ifTrue: [
		rOopTop := self allocateRegNotConflictingWith: (self registerMaskFor: rTop)
	].

	self deny: (rTop = NoReg or: [rOopTop = NoReg]).
	^ aBlock value: rTop value: rOopTop
