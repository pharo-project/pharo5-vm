simulation
mem: destAddress cp: sourceAddress y: bytes
	"For SpurGenerationScavenger>>copyToFutureSpace:bytes:. N.B. If ranges overlap, must use memmove."
	<doNotGenerate>
	self deny: ((destAddress <= sourceAddress and: [destAddress + bytes > sourceAddress])
				or: [sourceAddress <= destAddress and: [sourceAddress + bytes > destAddress]]).
	^self mem: destAddress mo: sourceAddress ve: bytes