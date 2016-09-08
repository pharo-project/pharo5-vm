C translation
valueOfBasicSelector: selector
	"Answer the numberic value of a basic constant accessed via the selector.
	 Answer nil if selector is not a basic constant accessor."
	"self mostBasicConstantSelectors collect: [:s| {s. self valueOfBasicSelector: s}]"
	| index key |
	^((index := self mostBasicConstantSelectors indexOf: selector) > 0
	  and: [(key := self mostBasicConstantNames at: index ifAbsent: []) notNil
	  and: [self includesKey: key]]) ifTrue:
		[classPool at: key]