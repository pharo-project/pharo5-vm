primitives
primitiveDeflateUpdateHashTable
	"Primitive. Update the hash tables after data has been moved by delta."
	| delta table tableSize tablePtr entry |
	<export: true>
	<var: #tablePtr type:'int *'>
	interpreterProxy methodArgumentCount = 2
		ifFalse:[^interpreterProxy primitiveFail].
	delta := interpreterProxy stackIntegerValue: 0.
	table := interpreterProxy stackObjectValue: 1.
	interpreterProxy failed ifTrue:[^nil].
	(interpreterProxy isWords: table)
		ifFalse:[^interpreterProxy primitiveFail].
	tableSize := interpreterProxy slotSizeOf: table.
	tablePtr := interpreterProxy firstIndexableField: table.
	0 to: tableSize-1 do:[:i|
		entry := tablePtr at: i.
		entry >= delta
			ifTrue:[tablePtr at: i put: entry - delta]
			ifFalse:[tablePtr at: i put: 0]].
	interpreterProxy pop: 2. "Leave rcvr on stack"