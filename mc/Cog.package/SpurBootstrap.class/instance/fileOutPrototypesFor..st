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
		[:className :isMeta :selector :method| | class category preamble source |
		class := Smalltalk classNamed: className.
		isMeta ifTrue: [class := class class].
		category := (class organization categoryOfElement: selector) ifNil:
						[self class categoryForClass: className meta: isMeta selector: selector].
		preamble := class name, ' methodsFor: ' , category asString printString, ' stamp: ''', method timeStamp, ''''.
		internalStream nextPut: $!; nextChunkPut: preamble; cr.
		source := method getSourceFromFile asString.
		source := source copyFrom: (source indexOfSubCollection: 'PROTOTYPE') + 9 to: source size.
		internalStream nextChunkPut: source; space; nextPut: $!; cr; cr].
	internalStream trailer.

	FileStream
		writeSourceCodeFrom: internalStream
		baseName: 'SpurBootstrapPrototypes'
		isSt: true
		useHtml: false