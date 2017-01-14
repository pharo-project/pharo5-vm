garbage collection
allMachineCodeObjectReferencesValid
	"Check that all methods have valid selectors, and that all linked sends are to valid targets and have valid cache tags"
	| ok cogMethod |
	<var: #cogMethod type: #'CogMethod *'>
	ok := true.
	cogMethod := self cCoerceSimple: methodZoneBase to: #'CogMethod *'.
	[cogMethod < methodZone limitZony] whileTrue:
		[cogMethod cmType ~= CMFree ifTrue:
			[(self asserta: (objectRepresentation checkValidOopReference: cogMethod selector)) ifFalse:
				[ok := false].
			 (self asserta: (self cogMethodDoesntLookKosher: cogMethod) = 0) ifFalse:
				[ok := false]].
		(cogMethod cmType = CMMethod
		 or: [cogMethod cmType = CMOpenPIC]) ifTrue:
			[(self asserta: ((self mapFor: cogMethod
								 performUntil: #checkIfValidOopRefAndTarget:pc:cogMethod:
								 arg: cogMethod asInteger) = 0)) ifFalse:
				[ok := false]].
		cogMethod cmType = CMClosedPIC ifTrue:
			[(self asserta: (self noTargetsFreeInClosedPIC: cogMethod)) ifFalse:
				[ok := false]].
		cogMethod := methodZone methodAfter: cogMethod].
	^ok