private-accessing
packagesAndPatches
	"SpurBootstrapMonticelloPackagePatcher new packagesAndPatches"
	packagesAndPatches ifNotNil:
		[^packagesAndPatches].
	packagesAndPatches := Dictionary new.
	SpurBootstrap new prototypeClassNameMetaSelectorMethodDo:
		[:className :isMeta :selector :method| | class methodReference source |
		 class := Smalltalk classNamed: className.
		 isMeta ifTrue:
			[class := class class].
		 methodReference := (class includesSelector: selector) ifTrue:
								[(class >> selector) methodReference].
		 (methodReference notNil
		  and: [methodReference category = Categorizer default]) ifTrue:
			[methodReference := nil].
		 source := method getSourceFromFile asString allButFirst: method selector size - selector size.
		 source first ~= selector first ifTrue:
			[source replaceFrom: 1 to: selector size with: selector startingAt: 1].
		 (packagesAndPatches
				at: (methodReference
						ifNotNil: [PackageOrganizer default packageOfMethod: methodReference]
						ifNil: [PackageOrganizer default packageOfClass: class])
				ifAbsentPut: [OrderedCollection new])
			add: (MCAddition of: (MCMethodDefinition
									className: className
									classIsMeta: isMeta
									selector: selector
									category: (methodReference
												ifNotNil: [methodReference category]
												ifNil: [SpurBootstrap
														categoryForClass: className
														meta: isMeta
														selector: selector])
									timeStamp: method timeStamp
									source: source))].
	^packagesAndPatches