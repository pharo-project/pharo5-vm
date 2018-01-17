rendering
zeroPaddedStringOfBase: base forFloat: aFloat 
	| stream |
	stream := String new writeStream.
	aFloat printOn: stream base: base.
	stream next: self precision-1 put: $0.
	^stream contents