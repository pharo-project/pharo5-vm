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
		[:className :isMeta :selector :method| | package category source definition |
		 (Smalltalk classNamed: className)
			ifNil: [package := self packageForMissingClassNamed: className]
			ifNotNil:
				[:behavior| | class methodReference |
				 class := isMeta ifTrue: [behavior class] ifFalse: [behavior].
				 (class includesSelector: selector) ifTrue:
					[methodReference := (class >> selector) methodReference.
					 category := methodReference category.
					 category first = $* ifTrue:
						[category := nil]].
				 package := (methodReference isNil
							  or: [methodReference category = Categorizer default
							  or: [methodReference category first = $*]]) "This for Scorch's override of InstructionClient>>classPrimitive:"
								ifTrue: [PackageOrganizer default packageOfClass: class]
								ifFalse: [PackageOrganizer default packageOfMethod: methodReference]].
		 source := method getSourceFromFile asString allButFirst: method selector size - selector size.
		 source first ~= selector first ifTrue:
			[source replaceFrom: 1 to: selector size with: selector startingAt: 1].
		 definition := MCAddition of: (MCMethodDefinition new
										initializeWithClassName: className
										classIsMeta: isMeta
										selector: selector
										category: (category ifNil: [SpurBootstrap
																	categoryForClass: className
																	meta: isMeta
																	selector: selector])
										timeStamp: method timeStamp
										source: source).
		 (method pragmaAt: #remove) ifNotNil:
			[definition := definition inverse].
		 (packagesAndPatches at: package ifAbsentPut: [OrderedCollection new])
			add: definition].
	^packagesAndPatches