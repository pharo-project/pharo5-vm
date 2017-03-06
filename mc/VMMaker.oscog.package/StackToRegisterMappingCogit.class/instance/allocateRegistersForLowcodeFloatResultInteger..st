inline primitive register allocation
allocateRegistersForLowcodeFloatResultInteger: aBlock
	<option: #LowcodeVM>
	<inline: true>

	| frTop rResult |
	frTop := NoReg.
	rResult := NoReg.

	"Float argument"
	self ssNativeTop nativeFloatRegisterOrNone ~= NoReg ifTrue: 
		[ frTop := self ssNativeTop nativeFloatRegisterOrNone].
	
	frTop = NoReg ifTrue:
		[ frTop := self allocateFloatRegNotConflictingWith: self emptyRegisterMask ].
	
	"Integer result".
	rResult := self allocateRegNotConflictingWith: (self emptyRegisterMask).
	
	self deny: (frTop = NoReg or: [rResult = NoReg]).

	^ aBlock value: frTop value: rResult

