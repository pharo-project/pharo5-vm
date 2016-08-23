C core
cDigitDiv: pDiv len: divLen rem: pRem len: remLen quo: pQuo len: quoLen 
	| dl ql dh dnh j t hi lo r3 l a b cond q r1r2 mul |
	<var: #pDiv type: #'unsigned int *'>
	<var: #pRem type: #'unsigned int *'>
	<var: #pQuo type: #'unsigned int *'>
	<var: #dh type: #'unsigned int'>
	<var: #dnh type: #'unsigned int'>
	<var: #r3 type: #'unsigned int'>
	<var: #q type: #'unsigned long long'>
	<var: #a type: #'unsigned long long'>
	<var: #b type: #'unsigned long long'>
	<var: #t type: #'unsigned long long'>
	<var: #mul type: #'unsigned long long'>
	<var: #hi type: #'unsigned long long'>
	<var: #lo type: #'unsigned long long'>
	<var: #r1r2 type: #'unsigned long long'>
	dl := divLen - 1.
	"Last actual byte of data (ST ix)"
	ql := quoLen.
	dh := self cDigitOf: pDiv at: dl - 1.
	dl = 1
		ifTrue: [dnh := 0]
		ifFalse: [dnh := self cDigitOf: pDiv at: dl - 2].
	1 to: ql do: 
		[:k | 
		"maintain quo*arg+rem=self"
		"Estimate rem/div by dividing the leading two unint32 of rem by dh."
		"The estimate is q = qhi*16r100000000+qlo, where qhi and qlo are uint32."
		j := remLen + 1 - k.
		"r1 := rem digitAt: j."
		(self cDigitOf: pRem at: j - 1)
			= dh
			ifTrue: [q := 16rFFFFFFFF]
			ifFalse: 
				["Compute q = (r1,r2)//dh, t = (r1,r2)\\dh.
				Note that r1,r2 are uint64, not uint32."
				"r2 := (rem digitAt: j - 2)."
				r1r2 := self cDigitOf: pRem at: j - 1.
				r1r2 := (r1r2 << 32) + (self cDigitOf: pRem at: j - 2).
				t := r1r2 \\ dh.
				q := r1r2 // dh.
				"Next compute (hi,lo) := q*dnh"
				mul := q * dnh.
				hi := mul >> 32.
				lo := mul bitAnd: 16rFFFFFFFF.
				"Correct overestimate of q.                
				Max of 2 iterations through loop -- see Knuth vol. 2"
				j < 3
					ifTrue: [r3 := 0]
					ifFalse: [r3 := self cDigitOf: pRem at: j - 3].
				
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
										lo := lo + 16r100000000 - dnh]
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
			hi := (self cDigitOf: pDiv at: i - 1) * (q >> 32).
			lo := (self cDigitOf: pDiv at: i - 1) * (q bitAnd: 16rFFFFFFFF).
			b := (self cDigitOf: pRem at: l - 1) - a - (lo bitAnd: 16rFFFFFFFF).
			self cDigitOf: pRem at: l - 1 put: (b bitAnd: 16rFFFFFFFF).
			"simulate arithmetic shift (preserving sign of b)"
			b := b >> 32 bitOr: (0 - (b >> 63) bitAnd: 16rFFFFFFFF00000000).
			a := hi + (lo >> 32) - b.
			l := l + 1].
		a > 0
			ifTrue: 
				["Add div back into rem, decrease q by 1"
				q := q - 1.
				l := j - dl.
				a := 0.
				1 to: divLen do: 
					[:i | 
					a := (a >> 32)
								+ (self cDigitOf: pRem at: l - 1) + (self cDigitOf: pDiv at: i - 1).
					self cDigitOf: pRem at: l - 1 put: (a bitAnd: 16rFFFFFFFF).
					l := l + 1]].
		self cDigitOf: pQuo at: quoLen - k put: q].
	^0