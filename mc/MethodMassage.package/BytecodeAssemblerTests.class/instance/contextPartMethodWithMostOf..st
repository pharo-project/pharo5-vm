test support
contextPartMethodWithMostOf: binaryBlock
	^(Array streamContents: [:s| ContextPart withAllSubclassesDo: [:sc| s nextPutAll: sc methodDict values]])
		inject: ContextPart methodDict anyOne
		into:
			[:m1 :m2|
			((1 to: m1 methodClass instSize) select: [:i| binaryBlock value: m1 value: i]) size >=
			((1 to: m2 methodClass instSize) select: [:i| binaryBlock value: m2 value: i]) size
				ifTrue: [m1]
				ifFalse: [m2]]