simulation
methodWithoutPrimitive: method
	"Answer either aMethod or a copy of aMehtod, such that the result does /not/ have a primitive."
	<doNotGenerate>
	| mn properties newProperties |
	method primitive = 0 ifTrue:
		[^method].
	mn := method methodNode.
	properties := mn properties.
	newProperties := properties copy.
	properties pragmas do:
		[:pragma|
		(pragma keyword beginsWith: #primitive:) ifTrue:
			[newProperties := newProperties copyWithout: pragma]].
	^mn
		instVarNamed: 'primitive' put: 0;
		instVarNamed: 'properties' put: newProperties;
		generate: method trailer using: method class