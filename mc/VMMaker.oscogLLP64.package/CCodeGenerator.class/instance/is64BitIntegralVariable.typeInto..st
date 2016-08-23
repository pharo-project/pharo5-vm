C translation support
is64BitIntegralVariable: node typeInto: aBlock
	| decl |
	^node isVariable
	  and: [(decl := self typeOfVariable: node name) notNil
	  and: [(#('usqLong' 'sqLong' 'unsigned long long' 'long long' 'unsigned __int64' '__int64')
			anySatisfy: [:type| decl beginsWith: type])
	  and: [aBlock value: ((decl endsWith: node name)
							ifTrue: [decl allButLast: node name size + 1]
							ifFalse: [decl]).
			true]]]