bytecode generators
genPushLiteralIndex: literalIndex "<SmallInteger>"
	<inline: false>
	| literal |
	literal := self getLiteral: literalIndex.
	^self genPushLiteral: literal