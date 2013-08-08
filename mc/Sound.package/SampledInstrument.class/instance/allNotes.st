other
allNotes
	"Answer a collection containing of all the unique sampled sounds used by this instrument."

	| r |
	r := IdentitySet new.
	r addAll: sustainedLoud.
	sustainedSoft ~~ sustainedLoud ifTrue: [r addAll: sustainedSoft].
	staccatoLoud ~~ sustainedLoud ifTrue: [r addAll: staccatoLoud].
	staccatoSoft ~~ staccatoLoud ifTrue: [r addAll: staccatoSoft].
	^ r asArray sort: [:n1 :n2 | n1 pitch < n2 pitch]
