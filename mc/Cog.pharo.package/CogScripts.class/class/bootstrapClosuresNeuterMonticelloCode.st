closure scripts
bootstrapClosuresNeuterMonticelloCode
	^'
!MCVersionLoader methodsFor: ''checking'' stamp: ''eem 6/12/2008 17:30''!
checkForModifications
	| modifications |
	modifications := versions select: [:ea | ea package workingCopy modified].
	true ifTrue: [^true].
	modifications isEmpty ifFalse: [self warnAboutLosingChangesTo: modifications].! !

!MCClassDefinition methodsFor: ''installing'' stamp: ''eem 6/12/2008 17:53''!
unload
	(Smalltalk at: #DoNotUnload ifAbsent: [false]) ifTrue: [^self].
	Smalltalk removeClassNamed: name! !

!MCMethodDefinition methodsFor: ''installing'' stamp: ''eem 6/12/2008 17:53''!
unload
	| previousVersion |
	(Smalltalk at: #DoNotUnload ifAbsent: [false]) ifTrue: [^self].
	self isOverrideMethod ifTrue: [previousVersion := self scanForPreviousVersion].
	previousVersion
		ifNil: [self actualClass ifNotNilDo: [:class | class removeSelector: selector]]
		ifNotNil: [previousVersion fileIn] ! !

!MCOrganizationDefinition methodsFor: ''as yet unclassified'' stamp: ''eem 6/12/2008 18:06''!
postloadOver: oldDefinition
	[SystemOrganization categories:
		(self
			reorderCategories: SystemOrganization categories
			original: (oldDefinition ifNil: [#()] ifNotNil: [oldDefinition categories]))]
		on: Error
		do: [:ex| Transcript cr; print: ex messageText; endEntry]! !

!MCPackageLoader methodsFor: ''private'' stamp: ''eem 6/12/2008 21:32''!
tryToLoad: aDefinition
	[aDefinition loadOver: (self obsoletionFor: aDefinition)]
		on: Error
		do: [:ex| self halt. errorDefinitions add: aDefinition]! !'