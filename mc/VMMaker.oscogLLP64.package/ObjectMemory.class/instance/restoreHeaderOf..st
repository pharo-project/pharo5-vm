become
restoreHeaderOf: obj
	"Restore the original header of the given obj from its forwarding block."
	<inline: true> "for subclasses"
	| fwdHeader fwdBlock objHeader |
	fwdHeader := self longAt: obj.
	fwdBlock := (fwdHeader bitAnd: AllButMarkBitAndTypeMask) << 1.
	self assert: (fwdHeader bitAnd: MarkBit) ~= 0.
	self assert: (self fwdBlockValid: fwdBlock).
	objHeader := self longAt: fwdBlock + self wordSize.
	self restoreHeaderOf: obj to: objHeader