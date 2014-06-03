re primitives
primPCREExecfromto

"<rcvr primPCREExec: searchObject from: fromInteger to: toInteger>, where rcvr is an object with instance variables:

	'patternStr compileFlags pcrePtr extraPtr errorStr errorOffset matchFlags'	

Apply the regular expression (stored in <pcrePtr> and <extratr>, generated from calls to primPCRECompile), to smalltalk String searchObject using <matchOptions>, beginning at offset <fromInteger> and continuing until offset <toInteger>.  If there is no match, answer nil.  Otherwise answer a ByteArray of offsets representing the results of the match."

	| searchObject searchBuffer length  result matchSpacePtr matchSpaceSize fromInteger toInteger |
	<export: true>
	<var:#searchBuffer	type: 'char *'>
	<var:#matchSpacePtr	type: 'int *'>
	
	"Load Parameters"
	toInteger := interpreterProxy stackIntegerValue: 0.
	fromInteger := interpreterProxy stackIntegerValue: 1.
	searchObject := interpreterProxy stackObjectValue: 2.	
	searchBuffer := interpreterProxy arrayValueOf: searchObject.
	length := interpreterProxy byteSizeOf: searchObject.
	self loadRcvrFromStackAt: 3.

	"Validate parameters"
	interpreterProxy success: (1 <= fromInteger).
	interpreterProxy success: (toInteger<=length).
	fromInteger := fromInteger - 1. "Smalltalk offsets are 1-based"
	interpreterProxy success: (fromInteger<=toInteger).

	"adjust length, searchBuffer"
	length := toInteger - fromInteger.
	searchBuffer := searchBuffer + fromInteger.

	"Load Instance Variables"
	pcrePtr := self rcvrPCREBufferPtr.
	extraPtr := self rcvrExtraPtr.
	matchFlags := self rcvrMatchFlags.
	matchSpacePtr := self rcvrMatchSpacePtr.
	matchSpaceSize := self rcvrMatchSpaceSize.
	interpreterProxy failed ifTrue:[^ nil].
	
	result := self 
		cCode: 'pcre_exec((pcre *)pcrePtr, (pcre_extra *)extraPtr, 
				searchBuffer, length, 0, matchFlags, matchSpacePtr, matchSpaceSize)'.
	interpreterProxy pop: 4; pushInteger: result.

	"empty call so compiler doesn't bug me about variables not used"
	self touch: searchBuffer; touch: matchSpacePtr; touch: matchSpaceSize; touch: length
