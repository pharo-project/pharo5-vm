type inference
returnTypeOrNilForSend: sendNode in: aTMethod
	"Answer the return type for a send.  Sends of known but as-yet-untyped methods answer nil."
	| sel |
	(self anyMethodNamed: (sel := sendNode selector)) ifNotNil:
		[:m|
		^m returnType ifNotNil: [:type| ^self baseTypeForType: type]].
	^self returnTypeForSend: sendNode in: aTMethod