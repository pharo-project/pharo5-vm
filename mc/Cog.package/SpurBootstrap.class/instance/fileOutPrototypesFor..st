public access
fileOutPrototypesFor: imageTypeOrArrayOfTypes
	"SpurBootstrap new fileOutPrototypesFor: 'squeak'"
	| internalStream |
	imageTypes := imageTypeOrArrayOfTypes isString
						ifTrue: [{imageTypeOrArrayOfTypes}]
						ifFalse: [imageTypeOrArrayOfTypes asArray].
	internalStream := WriteStream on: (String new: 1000).
	internalStream header; timeStamp.
	self prototypeClassNameMetaSelectorMethodDo:
		[:className :isMeta :selector :method| | classNameString class category preamble source |
		class := Smalltalk classNamed: className.
		isMeta
			ifTrue: [class := class class. classNameString := className, ' class']
			ifFalse: [classNameString := className].
		(method pragmaAt: #remove)
			ifNil:
				[category := class ifNotNil: [class organization categoryOfElement: selector].
				 (category notNil and: [category first = $*]) ifTrue:
					[category := nil].
				 category ifNil:
					[category := self class categoryForClass: className meta: isMeta selector: selector].
				preamble := classNameString, ' methodsFor: ' , category asString printString, ' stamp: ''', method timeStamp, ''''.
				internalStream nextPut: $!; nextChunkPut: preamble; cr.
				source := method getSourceFromFile asString.
				source := source copyFrom: (source indexOfSubCollection: 'PROTOTYPE') + 9 to: source size.
				(self selectorForPrototypeMethod: method) isBinary ifTrue:
					[source := (self selectorForPrototypeMethod: method), (source copyFrom: (source indexOf: Character space) to: source size)].
				internalStream nextChunkPut: source; space; nextPut: $!; cr; cr]
			ifNotNil:
				[source := classNameString, ' removeSelector: ', selector storeString.
				 internalStream nextChunkPut: source; cr; cr]].
	internalStream trailer.

	FileStream
		writeSourceCodeFrom: internalStream
		baseName: ('SpurBootstrapPrototypes-', (imageTypes fold: [:a :b| a, '-', b]) replaceAll: Character space with: $_)
		isSt: true
		useHtml: false