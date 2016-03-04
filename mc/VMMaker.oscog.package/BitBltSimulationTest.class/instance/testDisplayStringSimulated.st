tests
testDisplayStringSimulated
	"self run: #testAlphaCompositingSimulated"
	
	| bb f1 font |
	f1 := Form extent: 1@1 depth: 32.
	bb := BitBlt toForm: f1.
	bb combinationRule: 15.
	bb destX: 1.
	bb destY: 1.
	bb sourceX: 100.
	bb width: 100.
	font := TextStyle default fontOfSize: 21.
	bb simulatePrimitive: 'primitiveDisplayString' args: {'hello'. 1. 4. font characterToGlyphMap. font xTable. 1}.
