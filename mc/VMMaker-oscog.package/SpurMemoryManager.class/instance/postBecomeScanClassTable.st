become implementation
postBecomeScanClassTable
	"Scan the class table post-become (iff a pointer object or compiled method was becommed)"
	(becomeEffectsFlags anyMask: BecamePointerObjectFlag+BecameCompiledMethodFlag) ifFalse: [^self].
	
	0 to: (self numSlotsOf: classTableRootObj) - 1 do:
		[:i| | page |
		page := self fetchPointer: i ofObject: classTableRootObj.
		0 to: (self numSlotsOf: page) - 1 do:
			[:j| | classOrNil |
			classOrNil := self fetchPointer: j ofObject: page.
			classOrNil ~= nilObj ifTrue:
				[(self isForwarded: classOrNil) ifTrue:
					[classOrNil := self followForwarded: classOrNil.
					 self storePointer: j ofObject: page withValue: classOrNil].
				 self scanClassPostBecome: classOrNil effects: becomeEffectsFlags]]]