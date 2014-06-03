compiled methods
literal: offset
	"trap pushes of forwarded literals to help debug following forwarded primitive args.
	 it is not an error to push a forwarded literal, but we'd like to step through any resulting
	 primtive failure code"
	| lit |
	lit := super literal: offset.
	(objectMemory isOopForwarded: lit) ifTrue:
		[self halt: 'forwarded literal in ', thisContext selector].
	^lit