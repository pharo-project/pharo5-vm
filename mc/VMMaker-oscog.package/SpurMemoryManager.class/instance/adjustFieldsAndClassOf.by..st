initialization
adjustFieldsAndClassOf: oop by: offsetBytes 
	"Adjust all pointers in this object by the given offset."
	| fieldAddr fieldOop |
	<inline: true>
	<asmLabel: false>
	fieldAddr := oop + (self lastPointerOf: oop).
	[self oop: fieldAddr isGreaterThanOrEqualTo: oop + self baseHeaderSize] whileTrue:
		[fieldOop := self longAt: fieldAddr.
		 (self isNonImmediate: fieldOop) ifTrue:
			[self longAt: fieldAddr put: fieldOop + offsetBytes].
		 fieldAddr := fieldAddr - BytesPerOop]