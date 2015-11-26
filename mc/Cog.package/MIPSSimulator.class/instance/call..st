as yet unclassified
call: entryPC
	| zapValue |
	zapValue := self unsigned32ToSigned32: 16rBABABABA.
	^self call: entryPC with: zapValue with: zapValue with: zapValue with: zapValue