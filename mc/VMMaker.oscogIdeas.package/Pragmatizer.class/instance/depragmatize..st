convert pragmas to sends
depragmatize: methodReference
	"Depragmatize the method. Answer true if the method was not modified, and false
	if conversion was performed."

	| method newSource newStamp pragmas stamp |
	pragmas := OrderedCollection new.
	method := methodReference compiledMethod.
	method properties keysAndValuesDo: [:sel :p |
		(selectors includes: sel)
			ifTrue: [pragmas add: p]].
	pragmas isEmpty ifTrue: [^ true].
	newSource := pragmas
		inject: method getSourceFromFile asString
		into: [:src : pragma |
				src copyReplaceAll: pragma asString
					with: 'self ', pragma asString allButFirst allButLast, '.'].
		stamp := method timeStamp.
		newStamp := self newConvertToMessageSendStamp: stamp.
	Transcript
		print: method methodClass;
		nextPutAll: '>>';
		print: method selector;
		nextPut: Character space;
		nextPutAll: newStamp;
		cr; flush.
	method methodClass
		compile: newSource
		classified: methodReference category
		withStamp: newStamp
		notifying: nil.
	^false
