*MethodMassage-instance initialization
initClass: targetBehavior literalStream: literalsOrNil
	class := targetBehavior.
	literalsOrNil
		ifNil:
			[literalStream := WriteStream on: (Array new: 32).
			 addedSelectorAndMethodClassLiterals := false]
		ifNotNil:
			[literalStream := (WriteStream on: literalsOrNil asArray from: 1 to: literalsOrNil size) setToEnd.
			 addedSelectorAndMethodClassLiterals := true]