translation
tableFunctions
	"self tableFunctions"
	self cogitClass ~= self ifTrue: [^Set new].
	generatorTable ifNil:
		[^Set new].
	^Set new
		addAll: (generatorTable object
					collect: [:ea| ea generator]);
		addAll: (generatorTable object
					select: [:ea| ea spanFunction notNil]
					thenCollect: [:ea| ea spanFunction]);
		addAll: (generatorTable object
					select: [:ea| ea needsFrameFunction notNil]
					thenCollect: [:ea| ea needsFrameFunction]);
		addAll: (primitiveTable object
					select: [:ea| ea notNil and: [ea primitiveGenerator notNil]]
					thenCollect: [:ea| ea primitiveGenerator]);
		asSortedCollection: [:a :b| a caseInsensitiveLessOrEqual: b]