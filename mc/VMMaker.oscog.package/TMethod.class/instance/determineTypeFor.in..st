C code generation
determineTypeFor: aNode in: aCodeGen
	aNode isSend ifTrue:
		[aNode selector == #addressOf: ifTrue:
			[^(self determineTypeFor: aNode args first in: aCodeGen)
				ifNil: [#sqInt]
				ifNotNil: [:type| type, (type last isLetter ifTrue: [' *'] ifFalse: ['*'])]].
		(aNode selector == #at:
		 and: [aNode receiver isVariable]) ifTrue:
			[(aCodeGen typeOfVariable: aNode receiver name) ifNotNil:
				[:type|
				^type last = $*
					ifTrue: [aCodeGen
								extractTypeFor: aNode receiver name
								fromDeclaration: type allButLast]
					ifFalse: [type]]].
		^(aCodeGen anyMethodNamed: aNode selector)
			ifNil: [#sqInt]
			ifNotNil: [:method| method returnType]].
	aNode isAssignment ifTrue:
		[^self determineTypeFor: aNode expression in: aCodeGen].
	self error: 'don''t know how to extract return type from this kind of node'