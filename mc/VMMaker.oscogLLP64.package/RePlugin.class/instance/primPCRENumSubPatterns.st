re primitives
primPCRENumSubPatterns

"<rcvr primPCRENumSubPatterns>, where rcvr is an object with instance variables:

	'patternStr compileFlags pcrePtr extraPtr errorStr errorOffset matchFlags'	

Return the number of subpatterns captured by the compiled pattern."

	<export: true>
	| ncap |
	"Load Parameters"
	self loadRcvrFromStackAt: 0.
	"Load Instance Variables"
	pcrePtr := self rcvrPCREBufferPtr.
	self cCode: 'pcre_fullinfo((const pcre *)pcrePtr, NULL, PCRE_INFO_CAPTURECOUNT, &ncap)'
		inSmalltalk: [ncap := -1].
	interpreterProxy pop: 1; pushInteger: ncap.
