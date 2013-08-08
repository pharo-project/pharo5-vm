gc -- compaction
fwdBlockGet: blkSize
	"Return the address of a two- or four-word forwarding block or nil if no more entries are available."

	fwdTableNext := fwdTableNext + blkSize.
	fwdTableNext <= fwdTableLast
		ifTrue: [ ^ fwdTableNext ]
		ifFalse: [ ^ nil ].  "no more forwarding blocks available"