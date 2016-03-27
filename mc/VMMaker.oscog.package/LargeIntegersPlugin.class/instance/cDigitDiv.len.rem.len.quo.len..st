C core
cDigitDiv: pDiv len: divLen rem: pRem len: remLen quo: pQuo len: quoLen 
	| dl ql dh dnh j t hi lo r3 l a cond q r1r2 mul b |
	<var: #pDiv type: #'unsigned char *'>
	<var: #pRem type: #'unsigned char *'>
	<var: #pQuo type: #'unsigned char *'>
	<var: #dh type: #'unsigned int'>
	<var: #dnh type: #'unsigned int'>
	<var: #r3 type: #'unsigned int'>
	<var: #q type: #'unsigned int'>
	<var: #a type: #'unsigned int'>
	<var: #b type: #'unsigned int'>
	<var: #t type: #'unsigned int'>
	<var: #mul type: #'unsigned int'>
	<var: #hi type: #'unsigned int'>
	<var: #lo type: #'unsigned int'>
	<var: #r1r2 type: #'unsigned int'>
	dl := divLen - 1.
	"Last actual byte of data (ST ix)"
	ql := quoLen.
	dh := pDiv at: dl - 1.
	dl = 1
		ifTrue: [dnh := 0]
		ifFalse: [dnh := pDiv at: dl - 2].
	1 to: ql do: 
		[:k | 
		"maintain quo*arg+rem=self"
		"Estimate rem/div by dividing the leading two digits of rem by dh."
		"The estimate is q = qhi*16r100+qlo, where qhi and qlo are unsigned char."
		j := remLen + 1 - k.
		"r1 := rem digitAt: j."
		(pRem at: j - 1)
			= dh
			ifTrue: [q := 16rFF]
			ifFalse: 
				["Compute q = (r1,r2)//dh, t = (r1,r2)\\dh."
				"r2 := (rem digitAt: j - 2)."
				r1r2 := pRem at: j - 1.
				r1r2 := (r1r2 << 8) + (pRem at: j - 2).
				t := r1r2 \\ dh.
				q := r1r2 // dh.
				"Next compute (hi,lo) := q*dnh"
				mul := q * dnh.
				hi := mul >> 8.
				lo := mul bitAnd: 16rFF.
				"Correct overestimate of q.                
				Max of 2 iterations through loop -- see Knuth vol. 2"
				j < 3
					ifTrue: [r3 := 0]
					ifFalse: [r3 := pRem at: j - 3].
				
				[(t < hi
					or: [t = hi and: [r3 < lo]])
					ifTrue: 
						["i.e. (t,r3) < (hi,lo)"
						q := q - 1.
						hi = 0 "since hi is unsigned we must have this guard"
							ifTrue: [cond := false]
							ifFalse:
								[lo < dnh
									ifTrue: 
										[hi := hi - 1.
										lo := lo + 16r100 - dnh]
									ifFalse:
										[lo := lo - dnh].
								cond := hi >= dh]]
					ifFalse: [cond := false].
				cond]
					whileTrue: [hi := hi - dh]].
		"Subtract q*div from rem"
		l := j - dl.
		a := 0.
		1 to: divLen do: 
			[:i | 
			hi := (pDiv at: i - 1) * (q >> 8).
			lo := (pDiv at: i - 1) * (q bitAnd: 16rFF).
			b := (pRem at: l - 1) - a - (lo bitAnd: 16rFF).
			pRem at: l - 1 put: (b bitAnd: 16rFF).
			"BEWARE: signed shift is implementation defined in C..."
			b := b signedBitShift: -8.
				"This is a possible replacement to simulate arithmetic shift (preserving sign of b)"
				"b := b >> 8 bitOr: (0 - (b >> ((interpreterProxy sizeof: b)*8""CHAR_BIT""-1)) << 8)."
			a := hi + (lo >> 8) - b.
			l := l + 1].
		a > 0
			ifTrue: 
				["Add div back into rem, decrease q by 1"
				q := q - 1.
				l := j - dl.
				a := 0.
				1 to: divLen do: 
					[:i | 
					a := (a >> 8)
								+ (pRem at: l - 1) + (pDiv at: i - 1).
					pRem at: l - 1 put: (a bitAnd: 16rFF).
					l := l + 1]].
		pQuo at: quoLen - k put: q].
	^0