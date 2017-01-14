simulation only
disassembleCachedOop: address
	<doNotGenerate>
	| oopOrZero |
	"Answer a disassembly string for an implicit receiver cache entry in a Newspeak send."
	oopOrZero := objectMemory unalignedLongAt: address.
	^(objectMemory addressCouldBeObj: oopOrZero)
		ifTrue: [oopOrZero hex, ': ', (coInterpreter shortPrint: oopOrZero)]
		ifFalse: [oopOrZero = 0 ifTrue: [oopOrZero printString] ifFalse: [oopOrZero hex]]