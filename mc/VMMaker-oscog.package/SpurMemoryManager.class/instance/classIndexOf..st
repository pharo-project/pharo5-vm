header access
classIndexOf: objOop
	^(self longAt: objOop) bitAnd: self classIndexMask