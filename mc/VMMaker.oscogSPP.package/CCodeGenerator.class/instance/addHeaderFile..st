public
addHeaderFile: aString
	"Add a header file. As a hack we allow C preprocessor defs such as #ifdef"
	self assert: (('"<#' includes: aString first) or: [(aString last: 2) = '_H']).
	(aString first ~= $#
	 and: [headerFiles includes: aString]) ifTrue:
		[logger nextPutAll: 'warning, attempt to include ', aString, ' a second time'; cr; flush.
		 ^self].
	headerFiles addLast: aString