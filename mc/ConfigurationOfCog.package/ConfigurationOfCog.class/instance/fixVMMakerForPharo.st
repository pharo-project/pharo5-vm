doits
fixVMMakerForPharo
"fix VMMaker to fix bug"

"yeah, we need that "
Author fullName: 'MrVMMaker'.


ByteString compile: 'findSubstring: key in: body startingAt: start matchTable: matchTable
	"Answer the index in the string body at which the substring key first occurs, at or beyond start.  The match is determined using matchTable, which can be used to effect, eg, case-insensitive matches.  If no match is found, zero will be returned.

	The algorithm below is not optimum -- it is intended to be translated to C which will go so fast that it wont matter."
	| index |
	<primitive: ''primitiveFindSubstring'' module: ''MiscPrimitivePlugin''>
	
	<var: #key declareC: ''unsigned char *key''>
	<var: #body declareC: ''unsigned char *body''>
	<var: #matchTable declareC: ''unsigned char *matchTable''>

	key size = 0 ifTrue: [^ 0].
	start to: body size - key size + 1 do:
		[:startIndex |
		index := 1.
			[(matchTable at: (body at: startIndex+index-1) asciiValue + 1)
				= (matchTable at: (key at: index) asciiValue + 1)]
				whileTrue:
				[index = key size ifTrue: [^ startIndex].
				index := index+1]].
	^ 0
'.

Author reset.


