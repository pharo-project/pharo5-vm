accessing
beSilentDuring: aBlock
	"Temporarily suppress information about what is going on"
	| wasSilent result |
	wasSilent := self isSilent.
	self beSilent: true.
	result := aBlock value.
	self beSilent: wasSilent.
	^result