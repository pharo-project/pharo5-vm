debug support
shortPrint: oop
	| name classOop |
	(self isIntegerObject: oop) ifTrue: [^ '=' , (self integerValueOf: oop) printString , 
		' (' , (self integerValueOf: oop) hex , ')'].
	classOop := self fetchClassOf: oop.
	(self sizeBitsOf: classOop) = (Metaclass instSize +1*BytesPerWord) ifTrue: [
		^ 'class ' , (self nameOfClass: oop)].
	name := self nameOfClass: classOop.
	name size = 0 ifTrue: [name := '??'].
	name = 'String' ifTrue: [^ (self stringOf: oop) printString].
	name = 'ByteString' ifTrue: [^ (self stringOf: oop) printString].
	name = 'Symbol' ifTrue: [^ '#' , (self stringOf: oop)].
	name = 'ByteSymbol' ifTrue: [^ '#' , (self stringOf: oop)].
	name = 'Character' ifTrue: [^ '=' , (Character value: (self integerValueOf: 
				(self fetchPointer: 0 ofObject: oop))) printString].
	name = 'UndefinedObject' ifTrue: [^ 'nil'].
	name = 'False' ifTrue: [^ 'false'].
	name = 'True' ifTrue: [^ 'true'].
	name = 'Float' ifTrue: [^ '=' , (self dbgFloatValueOf: oop) printString].
	name = 'Association' ifTrue: [^ '(' ,
				(self shortPrint: (self longAt: oop + BaseHeaderSize)) ,
				' -> ' ,
				(self longAt: oop + BaseHeaderSize + BytesPerWord) hex8 , ')'].
	^('AEIOU' includes: name first)
		ifTrue: ['an ' , name]
		ifFalse: ['a ' , name]