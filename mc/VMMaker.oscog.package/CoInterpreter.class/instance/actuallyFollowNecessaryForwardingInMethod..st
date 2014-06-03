lazy become
actuallyFollowNecessaryForwardingInMethod: methodObj
	"To avoid any chance of a forwarded object during super sends
	 we follow the methodClassAssociation.  The forwarded object
	 send fault only copes with normal sends to instances."
	| cogMethod header litCount |
	<var: #cogMethod type: #'CogMethod *'>
	header := self rawHeaderOf: methodObj.
	(self isCogMethodReference: header) ifTrue:
		[cogMethod := self cCoerceSimple: header to: #'CogMethod *'.
		 "If the method class is not used we can avoid the forwarding
		  check for both the cogMehod and the bytecoded method."
		 cogMethod cmUsesMethodClass ifFalse:
			[^self].
		 cogit followForwardedLiteralsIn: cogMethod.
		 header := cogMethod methodHeader].
	litCount := self literalCountOfHeader: header. "Slang super expansion limitation"
	super
		actuallyFollowNecessaryForwardingInMethod: methodObj
		literalCount: litCount