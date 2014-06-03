lazy become
actuallyFollowNecessaryForwardingInMethod: methodObj
	"To avoid any chance of a forwarded object during super sends we follow the
	 methodClassAssociation.  The forwarded object send fault only copes with
	 normal sends to instances."
	<option: #SpurObjectMemory>
	<inline: true>
	self actuallyFollowNecessaryForwardingInMethod: methodObj
		literalCount: (self literalCountOf: methodObj)