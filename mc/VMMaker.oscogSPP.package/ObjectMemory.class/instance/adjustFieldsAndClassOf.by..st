initialization
adjustFieldsAndClassOf: oop by: offsetBytes 
	"Adjust all pointers in this object by the given offset."
	| fieldAddr fieldOop classHeader newClassOop |
	<inline: true>
	fieldAddr := oop + (self lastPointerOf: oop).
	[self oop: fieldAddr isGreaterThan: oop] whileTrue:
		[fieldOop := self longAt: fieldAddr.
		 (self isIntegerObject: fieldOop) ifFalse:
			[self longAt: fieldAddr put: fieldOop + offsetBytes].
		 fieldAddr := fieldAddr - self bytesPerOop].
	(self headerType: oop) ~= HeaderTypeShort ifTrue:
		["adjust class header if not a compact class"
		 classHeader := self longAt: oop - self wordSize.
		 newClassOop := (classHeader bitAnd: AllButTypeMask) + offsetBytes.
		 self longAt: oop - self wordSize put: (newClassOop bitOr: (classHeader bitAnd: TypeMask))]