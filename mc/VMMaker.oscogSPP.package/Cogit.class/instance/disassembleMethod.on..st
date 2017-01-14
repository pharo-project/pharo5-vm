disassembly
disassembleMethod: surrogateOrAddress on: aStream
	<doNotGenerate>
	| cogMethod mapEntries codeRanges |
	cogMethod := surrogateOrAddress isInteger
								ifTrue: [self cogMethodSurrogateAt: surrogateOrAddress]
								ifFalse: [surrogateOrAddress].
	cogMethod cmType = CMBlock ifTrue:
		[^self disassembleMethod: cogMethod cmHomeMethod on: aStream].
	(disassemblingMethod isNil
	 and: [self class initializationOptions at: #relativeAddressDisassembly ifAbsent: [false]]) ifTrue:
		[^[disassemblingMethod := cogMethod.
		    self disassembleMethod: surrogateOrAddress on: aStream] ensure:
			[disassemblingMethod := nil]].
	self printMethodHeader: cogMethod on: aStream.

	mapEntries := Dictionary new.
	(cogMethod cmType = CMMethod and: [cogMethod cmIsFullBlock]) ifFalse:
		[mapEntries at: cogMethod asInteger + cmEntryOffset put: 'entry'].
	
	cogMethod cmType = CMMethod ifTrue:
		[cogMethod cmIsFullBlock
			ifTrue: [mapEntries at: cogMethod asInteger + cbNoSwitchEntryOffset put: 'noSwitchEntry']
			ifFalse: [mapEntries at: cogMethod asInteger + cmNoCheckEntryOffset put: 'noCheckEntry']].

	cogMethod cmType = CMClosedPIC
		ifTrue:
			[mapEntries at: cogMethod asInteger + firstCPICCaseOffset put: 'ClosedPICCase0'.
			 1 to: MaxCPICCases - 1 do:
				[:i|
				mapEntries
					at: cogMethod asInteger + firstCPICCaseOffset + (i * cPICCaseSize)
					put: 'ClosedPICCase', i printString]]
		ifFalse:
			[self mapFor: cogMethod
				performUntil: #collectMapEntry:address:into:
				arg: mapEntries].

	NewspeakVM ifTrue:
		[objectRepresentation canPinObjects ifFalse:
			[mapEntries keys do:
				[:a|
				(mapEntries at: a) = #IsNSSendCall ifTrue:
					[mapEntries
						at: a + backEnd jumpShortByteSize
							put: {'Class'. #disassembleCachedOop:. (objectMemory wordSize)};
						at: a + backEnd jumpShortByteSize + objectMemory bytesPerOop
							put: {'ImplicitReceiver'. #disassembleCachedOop:. (objectMemory wordSize)}]]]].

	"This would all be far more elegant and simple if we used blocks.
	 But there are no blocks in C and the basic enumerators here need
	 to be used in the real VM.  Apologies."
	(codeRanges := self codeRangesFor: cogMethod) do:
		[:range|
		(cogMethod cmType = CMMethod) ifTrue:
			[mapEntries keysAndValuesDo:
				[:mcpc :label| | bcpc selectorOrNone |
				(((range includes: mcpc) or: [range last + 1 = mcpc])
				 and: [(AnnotationsWithBytecodePCs includes: label)
				 and: [range cogMethod stackCheckOffset > 0]]) ifTrue:
					[bcpc := self bytecodePCFor: mcpc startBcpc: range startpc in: range cogMethod.
					 bcpc ~= 0 ifTrue:
						[label = #IsSendCall
							ifTrue:
								[selectorOrNone := (self selectorForSendAt: mcpc annotation: IsSendCall in: cogMethod methodObject).
								 (selectorOrNone isInteger and: [objectMemory addressCouldBeOop: selectorOrNone]) ifTrue:
									[selectorOrNone := objectMemory stringOf: selectorOrNone].
								selectorOrNone := ' ', selectorOrNone]
							ifFalse: [selectorOrNone := ''].
						 mapEntries
							at: mcpc
							put: label, selectorOrNone, ' bc ', bcpc printString, '/', (bcpc + 1) printString]]]].
		(cogMethod blockEntryOffset ~= 0
		 and: [range first = (cogMethod blockEntryOffset + cogMethod asInteger)])
			ifTrue:
				[aStream nextPutAll: 'blockEntry:'; cr.
				 self blockDispatchFor: cogMethod
					perform: #disassemble:from:to:arg:
					arg: aStream]
			ifFalse:
				[range first > (cogMethod address + cmNoCheckEntryOffset) ifTrue:
					[self printMethodHeader: range cogMethod
						on: aStream].
				self disassembleFrom: range first to: range last labels: mapEntries on: aStream]].
	aStream nextPutAll: 'startpc: '; print: codeRanges first startpc; cr.
	(cogMethod cmType = CMMethod
	 or: [cogMethod cmType = CMOpenPIC]) ifTrue:
		[[self mapFor: cogMethod
			performUntil: #printMapEntry:mcpc:args:
			arg: { aStream. codeRanges. cogMethod }]
			on: AssertionFailure
			do: [:ex|
				ex primitiveChangeClassTo: ResumableVMError basicNew. ":) :) :)"
				ex resume: nil]].
	^cogMethod