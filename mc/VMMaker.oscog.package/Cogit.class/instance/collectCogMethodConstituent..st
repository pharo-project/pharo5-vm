profiling primitives
collectCogMethodConstituent: cogMethod
	"Answer a description of the mapping between machine code pointers and bytecode pointers for the Cog Method.
	 First value is the address of the cog method.
	 Following values are pairs of machine code pc and bytecode pc"
	<var: #cogMethod type: #'CogMethod *'>
	<var: #cogBlockMethod type: #'CogBlockMethod *'>
	| cm nSlots errCode cogBlockMethod address data |
	(cogMethod cmType = CMMethod) 
		ifFalse: [^self positiveMachineIntegerFor: cogMethod asUnsignedInteger ].
	cogBlockMethod := self cCoerceSimple: cogMethod to: #'CogBlockMethod *'.
	cogBlockMethod stackCheckOffset = 0 "isFrameless ?"
		ifTrue: [^self positiveMachineIntegerFor: cogMethod asUnsignedInteger].
	cm := cogMethod methodObject.
	nSlots := ((objectMemory byteSizeOf: cm) - (coInterpreter startPCOfMethod: cm)) * 2 + objectMemory minSlotsForShortening + 1."+1 for first address"
	data := objectMemory instantiateClass: (objectMemory splObj: ClassArray) indexableSize: nSlots.
	data ifNil: [^nil].
	coInterpreter pushRemappableOop: data.
	"The iteration assumes the object is the top remappable oop"
	address := (self positiveMachineIntegerFor: cogMethod asUnsignedInteger).
	address ifNil: [coInterpreter popRemappableOop. ^nil].
	coInterpreter
		storePointerUnchecked: 0
		ofObject: coInterpreter topRemappableOop
		withValue: address.
	cogConstituentIndex := 1.
	errCode := self
		mapFor: cogBlockMethod
		bcpc: (coInterpreter startPCOfMethod: cogMethod methodObject)
		performUntil: #collectCogConstituentFor:Annotation:Mcpc:Bcpc:Method:
		arg: cogMethod asVoidPointer.
	errCode ~= 0 ifTrue: [coInterpreter popRemappableOop. ^nil].
	cogConstituentIndex < nSlots ifTrue:
		[objectMemory shorten: coInterpreter topRemappableOop toIndexableSize: cogConstituentIndex].
	^coInterpreter popRemappableOop.