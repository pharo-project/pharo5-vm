private-accessing
packagesAndPatches
	"SpurBootstrapMonticelloPackagePatcher new packagesAndPatches"
	| spurBootstrap |
	packagesAndPatches ifNotNil:
		[^packagesAndPatches].
	packagesAndPatches := Dictionary new.
	spurBootstrap := SpurBootstrap new.
	imageTypes ifNotNil:
		[spurBootstrap imageTypes: imageTypes].
	spurBootstrap prototypeClassNameMetaSelectorMethodDo:
		[:className :isMeta :selector :method| | class methodReference source definition |
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
		 definition := MCAddition of: (MCMethodDefinition
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
										source: source).
		 (method pragmaAt: #remove) ifNotNil:
			[definition := definition inverse].
		 (packagesAndPatches
				at: (methodReference
						ifNotNil: [PackageOrganizer default packageOfMethod: methodReference]
						ifNil: [PackageOrganizer default packageOfClass: class])
				ifAbsentPut: [OrderedCollection new])
			add: definition].
	^packagesAndPatches