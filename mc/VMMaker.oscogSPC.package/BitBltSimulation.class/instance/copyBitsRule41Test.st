setup
copyBitsRule41Test
	"Test possible use of rule 41, rgbComponentAlpha:with: Nothing to return, just set up some variables"
	| gammaLookupTableOop ungammaLookupTableOop |
	<inline: false>
	
	combinationRule = 41
		ifTrue:["fetch the forecolor into componentAlphaModeColor."
			componentAlphaModeAlpha := 255.
			componentAlphaModeColor := 16777215.
			gammaLookupTable := nil.
			ungammaLookupTable := nil.
			interpreterProxy methodArgumentCount >= 2
				ifTrue:[
					componentAlphaModeAlpha := interpreterProxy stackIntegerValue: (interpreterProxy methodArgumentCount - 2).
					(interpreterProxy failed not)
						ifFalse: [^ interpreterProxy primitiveFail].
					componentAlphaModeColor := interpreterProxy stackIntegerValue: (interpreterProxy methodArgumentCount - 1).
					(interpreterProxy failed not)
						ifFalse: [^ interpreterProxy primitiveFail].
					interpreterProxy methodArgumentCount = 4
						ifTrue:[
							gammaLookupTableOop := interpreterProxy stackObjectValue: 1.
							(interpreterProxy isBytes: gammaLookupTableOop) 
								ifTrue:[gammaLookupTable := interpreterProxy firstIndexableField: gammaLookupTableOop.].
							ungammaLookupTableOop := interpreterProxy stackObjectValue: 0.
							(interpreterProxy isBytes: ungammaLookupTableOop) 
								ifTrue:[ungammaLookupTable := interpreterProxy firstIndexableField: ungammaLookupTableOop]]]
				ifFalse:[
					interpreterProxy methodArgumentCount = 1
						ifTrue: [
							componentAlphaModeColor := interpreterProxy stackIntegerValue: 0.
							(interpreterProxy failed not)
								ifFalse: [^ interpreterProxy primitiveFail]]
						ifFalse:[^ interpreterProxy primitiveFail]]].	


