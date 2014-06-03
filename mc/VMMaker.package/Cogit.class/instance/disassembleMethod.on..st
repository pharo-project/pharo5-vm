disassembly
disassembleMethod: surrogateOrAddress on: aStream
	<doNotGenerate>
	| cogMethod mapEntries codeRanges |
	cogMethod := surrogateOrAddress isInteger
								ifTrue: [self cogMethodSurrogateAt: surrogateOrAddress]
								ifFalse: [surrogateOrAddress].
	cogMethod cmType = CMBlock ifTrue:
		[^self disassembleMethod: cogMethod cmHomeMethod on: aStream].
	self printMethodHeader: cogMethod on: aStream.

	(mapEntries := Dictionary new)
		at: cogMethod asInteger + cmEntryOffset put: 'entry'.
	
	cogMethod cmType = CMMethod ifTrue:
		[mapEntries at: cogMethod asInteger + cmNoCheckEntryOffset put: 'noCheckEntry'.
		self cppIf: NewspeakVM
			ifTrue: [mapEntries at: cogMethod asInteger + dynSuperEntryAlignment put: 'dynSuperEntry']].

	cogMethod cmType = CMClosedPIC ifTrue:
		[mapEntries at: cogMethod asInteger + firstCPICCaseOffset put: 'ClosedPICCase0'.
		 1 to: numPICCases - 1 do:
			[:i|
			mapEntries
				at: cogMethod asInteger + firstCPICCaseOffset + (i * cPICCaseSize)
				put: 'ClosedPICCase', i printString]].

	self mapFor: cogMethod
		performUntil: #collectMapEntry:address:into:
		arg: mapEntries.

	self cppIf: NewspeakVM
		ifTrue:
			[mapEntries keys do:
				[:a|
				(mapEntries at: a) = #IsNSSendCall ifTrue:
					[mapEntries
						at: a + backEnd jumpShortByteSize
							put: {'Class'. #disassembleCachedOop:. BytesPerWord};
						at: a + backEnd jumpShortByteSize + BytesPerOop
							put: {'ImplicitReceiver'. #disassembleCachedOop:. BytesPerWord}]]].

	"This would all be far more elegant and simple if we used blocks.
	 But there are no blocks in C and the basic enumerators here need
	 to be used in the real VM.  Apologies."
	(codeRanges := self codeRangesFor: cogMethod) do:
		[:range|
		(cogMethod cmType = CMMethod) ifTrue:
			[mapEntries keysAndValuesDo:
				[:mcpc :label| | bcpc |
				((range includes: mcpc)
				 and: [(#(IsSendCall HasBytecodePC) includes: label)
				 and: [range cogMethod stackCheckOffset > 0]]) ifTrue:
					[bcpc := self bytecodePCFor: mcpc startBcpc: range startpc in: range cogMethod.
					 bcpc ~= 0 ifTrue:
						[mapEntries at: mcpc put: label, ' bc ', bcpc printString, '/', (bcpc + 1) printString]]]].
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