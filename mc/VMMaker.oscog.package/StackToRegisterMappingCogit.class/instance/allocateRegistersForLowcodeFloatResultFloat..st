inline primitive register allocation
allocateRegistersForLowcodeFloatResultFloat: aBlock
	<option: #LowcodeVM>
	<inline: true>

	| frTop frResult |
	frTop := NoReg.
	frResult := NoReg.

	"Float argument"
	self ssNativeTop nativeFloatRegisterOrNone ~= NoReg ifTrue: 
		[ frTop := self ssNativeTop nativeFloatRegisterOrNone].
	
	frTop = NoReg ifTrue:
		[ frTop := self allocateFloatRegNotConflictingWith: self emptyRegisterMask ].
	
	"Float result".
	frResult := self allocateFloatRegNotConflictingWith: (self registerMaskFor: frTop).
	self deny: (frTop = NoReg or: [frResult = NoReg]).

	^ aBlock value: frTop value: frResult
