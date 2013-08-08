private
commandLine: aString
	"Start up this launcher from within Squeak as if it Squeak been launched the given command line."

	| dict tokens cmd arg |
	dict := Dictionary new.
	tokens := (aString findTokens: ' ') readStream.
	[ 
	cmd := tokens next.
	arg := tokens next.
	cmd notNil and: [ arg notNil ] ] whileTrue: [ dict at: cmd put: arg ].
	self parameters: dict.
	self startUp