*sound-piano rolls
triggerActionFromPianoRoll

	| evt |
	"a hack to allow for abitrary morphs to be dropped into piano roll"
	self world ifNil: [^self].
	evt := MouseEvent basicNew setType: nil position: self center buttons: 0 hand: self world activeHand.
	self programmedMouseUp: evt for: self.

