debug support
findStringBeginningWith: aCString
	"Print the oops of all string-like things that start with the same characters as aCString"
	<api>
	<var: #aCString type: #'char *'>
	| cssz obj sz |
	cssz := self strlen: aCString.
	obj := self firstObject.
	[self oop: obj isLessThan: freeStart] whileTrue:
		[(self isFreeObject: obj)
			ifTrue:
				[sz := self sizeOfFree: obj]
			ifFalse:
				[((self isBytesNonImm: obj)
				  and: [(self lengthOf: obj) >= cssz
				  and: [(self str: aCString n: (self pointerForOop: obj + self baseHeaderSize) cmp: cssz) = 0]]) ifTrue:
					[coInterpreter printHex: obj; space; printNum: (self lengthOf: obj); space; printOopShort: obj; cr].
				 sz := self sizeBitsOf: obj].
		 obj := self oopFromChunk: obj + sz]