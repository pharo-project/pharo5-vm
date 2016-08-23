return bytecodes
baseFrameReturn
	"| contextToReturnTo |
	contextToReturnTo := self frameCallerContext: localFP.
	(self stringOf: (self penultimateLiteralOf: (self fetchPointer: MethodIndex ofObject: contextToReturnTo))) = #indexOf:startingAt:ifAbsent: ifTrue:
		[self halt]."
	^super baseFrameReturn