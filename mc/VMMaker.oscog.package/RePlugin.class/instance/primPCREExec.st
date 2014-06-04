re primitives
primPCREExec

"<rcvr primPCREExec: searchObject>, where rcvr is an object with instance variables:

	'patternStr compileFlags pcrePtr extraPtr errorStr errorOffset matchFlags'	

Apply the regular expression (stored in <pcrePtr> and <extratr>, generated from calls to primPCRECompile), to smalltalk String searchObject using <matchOptions>.  If there is no match, answer nil.  Otherwise answer a ByteArray of offsets representing the results of the match."

	| searchObject searchBuffer length  result matchSpacePtr matchSpaceSize |
	<export: true>
	<var:#searchBuffer	type: 'char *'>
	<var:#matchSpacePtr	type: 'int *'>
	
	"Load Parameters"
	searchObject := interpreterProxy stackObjectValue: 0.	
	searchBuffer := interpreterProxy arrayValueOf: searchObject.
	length := interpreterProxy byteSizeOf: searchObject.
	self loadRcvrFromStackAt: 1.
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

	interpreterProxy pop: 2; pushInteger: result.

	"empty call so compiler doesn't bug me about variables not used"
	self touch: searchBuffer; touch: matchSpacePtr; touch: matchSpaceSize; touch: length
