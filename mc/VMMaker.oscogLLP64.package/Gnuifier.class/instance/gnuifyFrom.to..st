as yet unclassified
gnuifyFrom: inFileStream to: outFileStream

"convert interp.c to use GNU features"

	| inData beforeInterpret inInterpret inInterpretVars beforePrimitiveResponse inPrimitiveResponse |

	inData := inFileStream upToEnd withSqueakLineEndings.
	inFileStream close.

	"print a header"
	outFileStream
		nextPutAll: '/* This file has been post-processed for GNU C */';
		cr; cr; cr.

	beforeInterpret := true.    "whether we are before the beginning of interpret()"
	inInterpret := false.     "whether we are in the middle of interpret"
	inInterpretVars := false.    "whether we are in the variables of interpret"
	beforePrimitiveResponse := true.  "whether we are before the beginning of primitiveResponse()"
	inPrimitiveResponse := false.   "whether we are inside of primitiveResponse"
	'Gnuifying'
		displayProgressAt: Sensor cursorPoint
		from: 1 to: (inData occurrencesOf: Character cr)
		during:
			[:bar | | lineNumber |
			lineNumber := 0.
			inData linesDo:
				[ :inLine | | outLine extraOutLine |
				bar value: (lineNumber := lineNumber + 1).
				outLine := inLine. 	"print out one line for each input line; by default, print out the line that was input, but some rules modify it"
				extraOutLine := nil.   "occasionally print a second output line..."
				beforeInterpret ifTrue: [
					(inLine = '#include "sq.h"') ifTrue: [
						outLine := '#include "sqGnu.h"'. ].
					(inLine beginsWith: 'interpret(void)') ifTrue: [
						"reached the beginning of interpret"
						beforeInterpret := false.
						inInterpret := true.
						inInterpretVars := true. ] ]
				ifFalse: [
				inInterpretVars ifTrue: [
					(inLine findString: 'register struct foo * foo = &fum;') > 0 ifTrue: [
						outLine := 'register struct foo * foo FOO_REG = &fum;' ].
					(inLine findString: ' localIP;') > 0 ifTrue: [
						outLine := '	register char* localIP IP_REG;' ].
					(inLine findString: ' localFP;') > 0 ifTrue: [
						outLine := '	register char* localFP FP_REG;' ].
					(inLine findString: ' localSP;') > 0 ifTrue: [
						outLine := '	register char* localSP SP_REG;' ].
					(inLine findString: ' currentBytecode;') > 0 ifTrue: [
						outLine := '	register sqInt currentBytecode CB_REG;' ].
					inLine isEmpty ifTrue: [
						"reached end of variables"
						inInterpretVars := false.
						outLine := '    JUMP_TABLE;'.
						extraOutLine := '\#if MULTIPLEBYTECODESETS\	if(!asserta((sizeof(jumpTable)/sizeof(jumpTable[0])) >= 512))\		error("bytecode jumpTable too small");\#endif\' withCRs]]
				ifFalse: [
				inInterpret ifTrue: [
					"working inside interpret(); translate the switch statement"
					(inLine beginsWith: '		case ') ifTrue: [
						| tokens |
						tokens := inLine findTokens: '	 :'.
						outLine := '		CASE(', tokens second, ')'.
						tokens size > 2 ifTrue:
							[(tokens allButFirst: 2) do:
								[:token| outLine := outLine, ' ', token]]].
					inLine = '			break;' ifTrue: [
						outLine := '			BREAK;' ].
					inLine = '}' ifTrue: [
						"all finished with interpret()"
						inInterpret := false. ] ]
				ifFalse: [
				beforePrimitiveResponse ifTrue: [
					(inLine beginsWith: 'primitiveResponse(') ifTrue: [
						"into primitiveResponse we go"
						beforePrimitiveResponse := false.
						inPrimitiveResponse := true.
						extraOutLine := '    PRIM_TABLE;'.  ] ]
				ifFalse: [
				inPrimitiveResponse ifTrue: [
					(inLine = '	switch (primitiveIndex) {') ifTrue: [
						extraOutLine := outLine.
						outLine := '	PRIM_DISPATCH;' ].
					(inLine = '	switch (GIV(primitiveIndex)) {') ifTrue: [
						extraOutLine := outLine.
						outLine := '	PRIM_DISPATCH;' ].
					(inLine beginsWith: '	case ') ifTrue: [
						| caseLabel |
						caseLabel := (inLine findTokens: '	 :') second.
						outLine := '	CASE(', caseLabel, ')' ].
					inLine = '}' ifTrue: [
						inPrimitiveResponse := false ] ].
				] ] ] ].

				outFileStream nextPutAll: outLine; cr.
				extraOutLine ifNotNil: [
					outFileStream nextPutAll: extraOutLine; cr ]]].

	outFileStream close