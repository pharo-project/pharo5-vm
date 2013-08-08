C core
cdigitMontgomery: pBytesFirst
				len: firstLen
				times: pBytesSecond
				len: secondLen
				modulo: pBytesThird
				len: thirdLen
				mInvModB: mInv
				into: pBytesRes
				
	| u limit1 limit2 limit3 accum lastByte |
	<var: #pBytesFirst type: 'unsigned char * '>
	<var: #pBytesSecond type: 'unsigned char * '>
	<var: #pBytesThird type: 'unsigned char * '>
	<var: #pBytesRes type: 'unsigned char * '>
	<var: #accum type: 'usqInt '>
	<var: #u type: 'unsigned char  '>
	<var: #lastByte type: 'unsigned char  '>
	limit1 := firstLen - 1.
	limit2 := secondLen - 1.
	limit3 := thirdLen - 1.
	lastByte := 0.
	0 to: limit1 do: 
		[:i | 
		accum := (pBytesRes at: 0) + ((pBytesFirst at: i)*(pBytesSecond at: 0)).
		u := accum * mInv bitAnd: 255.
		accum :=  accum + (u * (pBytesThird at: 0)).
		1 to: limit2 do: [:k |
			accum := (accum >> 8) + (pBytesRes at: k) + ((pBytesFirst at: i)*(pBytesSecond at: k)) + (u * (pBytesThird at: k)).
			pBytesRes at: k-1 put: (accum bitAnd: 255)].
		secondLen to: limit3 do: [:k |
			accum := (accum >> 8) + (pBytesRes at: k) + (u * (pBytesThird at: k)).
			pBytesRes at: k-1 put: (accum bitAnd: 255)].
		accum := (accum >> 8) + lastByte.
		pBytesRes at: limit3 put: (accum bitAnd: 255).
		lastByte := accum >> 8].
	firstLen to: limit3 do: 
		[:i | 
		accum := (pBytesRes at: 0).
		u := accum * mInv bitAnd: 255.
		accum := accum + (u * (pBytesThird at: 0)).
		1 to: limit3 do: [:k |
			accum := (accum >> 8) + (pBytesRes at: k) + (u * (pBytesThird at: k)).
			pBytesRes at: k-1 put: (accum bitAnd: 255)].
		accum := (accum >> 8) + lastByte.
		pBytesRes at: limit3 put: (accum bitAnd: 255).
		lastByte := accum >> 8].
	(lastByte = 0 and: [(self cDigitCompare: pBytesThird with: pBytesRes len: thirdLen) = 1]) ifFalse: [
		"self cDigitSub: pBytesThird len: thirdLen with: pBytesRes len: thirdLen into: pBytesRes"
		accum := 0.
		0 to: limit3 do: 
			[:i | 
			accum := accum + (pBytesRes at: i) - (pBytesThird at: i).
			pBytesRes at: i put: accum - (accum // 256 * 256).
			"sign-tolerant form of (z bitAnd: 255)"
			accum := accum // 256]].