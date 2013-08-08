other
testAtPitch: aPitch
	"SampledInstrument testAtPitch: 'c4'"

	| pattern |
	pattern := (#(
		(c4 0.64 100) 
		(c4 0.64 200) 
		(c4 0.64 400) 
		(c4 0.64 600) 
		(c4 0.64 800) 
		(c4 1.28 1000) 
		(c4 1.28 400) 
		(c4 0.32 500) 
		(c4 0.32 500) 
		(c4 0.32 500) 
		(c4 0.32 500) 
		(c4 0.16 500) 
		(c4 0.16 500) 
		(c4 0.16 500) 
		(c4 0.16 500) 
		(c4 0.16 500) 
		(c4 0.08 500) 
		(c4 0.08 500) 
		(c4 0.16 500) 
		(c4 0.08 500) 
		(c4 0.08 500) 
		(c4 0.64 500))
			collect: [:triple | triple copy at: 1 put: aPitch; yourself]).
	(AbstractSound noteSequenceOn: self from: pattern) play.
