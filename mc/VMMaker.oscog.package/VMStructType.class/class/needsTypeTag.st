translation
needsTypeTag
	self instVarNamesAndTypesForTranslationDo:
		[:ivn :type|
		((type isArray ifTrue: [type] ifFalse: [{type}]) anySatisfy:
			[:str|
			str isString
			and: [str includesSubstring: self structTagName]]) ifTrue:
				[^true]].
	^false

	"VMStructType allSubclasses select: [:sc| sc needsTypeTag]"