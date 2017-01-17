C translation
generateFlag: msgNode on: aStream indent: level
	"Compoensate for the use of self flag: #aSymbol.  We used to translate  symbols
	 as strings unless they were quoted via #aSymbol asSymbol. But this is too tedious,
	 so we now translate symbols directly.  The only use that this affected was in
		 self flag: #aSymbol,
	 so hard-code it to produce a string value.  Note that this isn't strictly necessary
	 because there's a
		#define flag(foo) 0
	 in C land, but it makes the generated C less dissonant."

	aStream
		nextPutAll: 'flag(';
		nextPutAll: (self cLiteralFor: msgNode args last value asString);
		nextPut: $)