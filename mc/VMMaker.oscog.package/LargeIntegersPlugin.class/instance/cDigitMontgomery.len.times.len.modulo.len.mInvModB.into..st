C core
cDigitMontgomery: pFirst
				len: firstLen
				times: pSecond
				len: secondLen
				modulo: pThird
				len: thirdLen
				mInvModB: mInv
				into: pRes
				
	| u limit1 limit2 limit3 accum accum2 accum3 lastDigit |
	<var: #pFirst type: #'unsigned int *'>
	<var: #pSecond type: #'unsigned int *'>
	<var: #pThird type: #'unsigned int *'>
	<var: #mInv type: #'unsigned int'>
	<var: #pRes type: #'unsigned int *'>
	<var: #accum type: #'unsigned long long'>
	<var: #accum2 type: #'unsigned long long'>
	<var: #accum3 type: #'unsigned long long'>
	<var: #u type: #'unsigned long long '>
	<var: #lastDigit type: #'unsigned int '>
	limit1 := firstLen - 1.
	limit2 := secondLen - 1.
	limit3 := thirdLen - 1.
	lastDigit := 0.
	0 to: limit1 do: 
		[:i | 
		accum3 := self cDigitOf: pFirst at: i.
		accum3 := accum3*(self cDigitOf: pSecond at: 0) + (self cDigitOf: pRes at: 0).
		u := accum3 * mInv bitAnd: 16rFFFFFFFF.
		accum2 :=  u * (self cDigitOf: pThird at: 0).
		accum := (accum2 bitAnd: 16rFFFFFFFF) + (accum3 bitAnd: 16rFFFFFFFF).
		accum := (accum >> 32) + (accum2 >> 32) + (accum3 >> 32).
		1 to: limit2 do: [:k |
			accum3 := self cDigitOf: pFirst at: i.
			accum3 := accum3*(self cDigitOf: pSecond at: k) + (self cDigitOf: pRes at: k).
			accum2 :=  u * (self cDigitOf: pThird at: k).
			accum := accum + (accum2 bitAnd: 16rFFFFFFFF) + (accum3 bitAnd: 16rFFFFFFFF).
			self cDigitOf: pRes at: k-1 put: (accum bitAnd: 16rFFFFFFFF).
			accum := (accum >> 32) + (accum2 >> 32) + (accum3 >> 32)].
		secondLen to: limit3 do: [:k |
			accum2 :=  u * (self cDigitOf: pThird at: k).
			accum := accum + (self cDigitOf: pRes at: k) + (accum2 bitAnd: 16rFFFFFFFF).
			self cDigitOf: pRes at: k-1 put: (accum bitAnd: 16rFFFFFFFF).
			accum := (accum >> 32) + (accum2 >> 32)].
		accum := accum + lastDigit.
		self cDigitOf: pRes at: limit3 put: (accum bitAnd: 16rFFFFFFFF).
		lastDigit := accum >> 32].
	firstLen to: limit3 do: 
		[:i | 
		accum := (self cDigitOf: pRes at: 0).
		u := accum * mInv bitAnd: 16rFFFFFFFF.
		accum := accum + (u * (self cDigitOf: pThird at: 0)).
		accum := accum >> 32.
		1 to: limit3 do: [:k |
			accum2 :=  u * (self cDigitOf: pThird at: k).
			accum := accum + (self cDigitOf: pRes at: k) + (accum2 bitAnd: 16rFFFFFFFF).
			self cDigitOf: pRes at: k-1 put: (accum bitAnd: 16rFFFFFFFF).
			accum := (accum >> 32) + (accum2 >> 32)].
		accum := accum + lastDigit.
		self cDigitOf: pRes at: limit3 put: (accum bitAnd: 16rFFFFFFFF).
		lastDigit := accum >> 32].
	(lastDigit = 0 and: [(self cDigitCompare: pThird with: pRes len: thirdLen) = 1]) ifFalse: [
		"self cDigitSub: pThird len: thirdLen with: pRes len: thirdLen into: pRes"
		accum := 0.
		0 to: limit3 do: 
			[:i | 
			accum := accum + (self cDigitOf: pRes at: i) - (self cDigitOf: pThird at: i).
			self cDigitOf: pRes at: i put: (accum bitAnd: 16rFFFFFFFF).
			accum := 0 - (accum >> 63)]].
	^0