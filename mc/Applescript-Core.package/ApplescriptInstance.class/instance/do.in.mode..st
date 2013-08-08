interpreting
do: aString in: contextOSAID mode: anInteger
	"Answer text result of executing Applescript aString in context contexOSAID in mode: anInteger"

	| source object result |
	source := AEDesc textTypeOn: aString.
	object := AEDesc new.
	result := self	
		primOSADoScript: source
		in: contextOSAID
		mode: anInteger
		resultType: (DescType of: 'ut16')
		to: object.
	source dispose.
	result isZero ifFalse: [^nil].
	^object asStringThenDispose