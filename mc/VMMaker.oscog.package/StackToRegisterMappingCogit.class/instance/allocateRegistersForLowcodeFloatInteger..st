inline primitive register allocation
allocateRegistersForLowcodeFloatInteger: aBlock
	<option: #LowcodeVM>
	<inline: true>
	
	"Used by storeFloat32ToMemory and storeFloat64ToMemory"
	| frTop rTop |
	frTop := rTop := NoReg.

	"Integer registers"
	self ssNativeTop nativeRegisterOrNone ~= NoReg ifTrue: 
		[ rTop := self ssNativeTop nativeRegisterOrNone].

	rTop = NoReg ifTrue:
		[ rTop := self allocateRegNotConflictingWith: 0 ].

	"Float registers"
	(self ssNativeValue: 1) nativeFloatRegisterOrNone ~= NoReg ifTrue: 
		[ frTop := (self ssNativeValue: 1) nativeFloatRegisterOrNone].
	
	frTop = NoReg ifTrue:
		[ frTop := self allocateFloatRegNotConflictingWith: 0 ].
	
	self deny: (frTop = NoReg or: [rTop = NoReg]).

	^ aBlock value: frTop value: rTop