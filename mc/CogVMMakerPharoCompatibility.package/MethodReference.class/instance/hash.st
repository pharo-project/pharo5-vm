comparing
hash
	"Answer a SmallInteger whose value is related to the receiver's  
	identity."
	^ (self species hash bitXor: self classSymbol hash)
		bitXor: self methodSymbol hash