munging
preparePrototypes
	replacements := OrderedCollection new.
	heap classTableObjectsDo:
		[:class| | name isMeta |
		name := heap
					fetchPointer: interpreter classNameIndex
					ofObject: ((isMeta := (heap numSlotsOf: class) = interpreter metaclassNumSlots)
								ifTrue: [heap fetchPointer: interpreter thisClassIndex ofObject: class]
								ifFalse: [class]).
		name := interpreter stringOf: name.
		self prototypeClassNameMetaSelectorMethodDo:
			[:protoClassName :protoIsMeta :selector :method|
			 (protoClassName = name
			  and: [protoIsMeta = isMeta]) ifTrue:
				[replacements addLast: {class. selector. method}]]]