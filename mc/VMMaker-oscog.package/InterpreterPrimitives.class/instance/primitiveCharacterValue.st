object access primitives
primitiveCharacterValue
	| characterCode characterObject |
	characterObject := self stackTop.
	characterCode := CharacterTable
						ifNil: [objectMemory integerObjectOf: (objectMemory characterValueOf: characterObject)]
						ifNotNil: [objectMemory fetchPointer: CharacterValueIndex ofObject: characterObject].
	"the Character must be the receiver for safety"
	self pop: 1 thenPush: characterCode