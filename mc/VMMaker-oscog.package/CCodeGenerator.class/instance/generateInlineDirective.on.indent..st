C translation
generateInlineDirective: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	aStream nextPutAll: '/* inline: '.
	aStream nextPutAll: msgNode args first name.
	aStream nextPutAll: ' */'.
