inline primitive register allocation
allocateRegistersForLowcodeFloatResultInteger2: aBlock
	<option: #LowcodeVM>
	<inline: true>

	| frTop rResult rResult2 |
	frTop := NoReg.
	rResult2 := rResult := NoReg.

	"Float argument"
	self ssNativeTop nativeFloatRegisterOrNone ~= NoReg ifTrue: 
		[ frTop := self ssNativeTop nativeFloatRegisterOrNone].
	
	frTop = NoReg ifTrue:
		[ frTop := self allocateFloatRegNotConflictingWith: self emptyRegisterMask ].
	
	"Integer result".
	rResult := self allocateRegNotConflictingWith: (self emptyRegisterMask).
	rResult2 := self allocateRegNotConflictingWith: (self registerMaskFor: rResult).
	
	self deny: (frTop = NoReg or: [rResult = NoReg or: [rResult2 = NoReg]]).

	^ aBlock value: frTop value: rResult value: rResult2

