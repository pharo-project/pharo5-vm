instance creation
example
	"Envelope example"

	| p |
	p := Array with: 0@0 with: 100@1.0 with: 250@0.7 with: 400@1.0 with: 500@0.
	^ (self points: p loopStart: 2 loopEnd: 4) sustainEnd: 1200.
