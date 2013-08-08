initialization
setAlpha: alph beta: bet
	"Set alpha and beta, compute wavelet coeefs, and derive hFilter and lFilter"
	| tcosa tcosb tsina tsinb |
	alpha := alph.
	beta := bet.

	"WaveletCoeffs..."
	"precalculate cosine of alpha and sine of beta"
	tcosa := alpha cos.
	tcosb := beta cos.
	tsina := alpha sin.
	tsinb := beta sin.
	coeffs := Array new: 6.
	
	"calculate first two wavelet coefficients a := a(-2) and b := a(-1)"
	coeffs at: 1 put: ((1.0 + tcosa + tsina) * (1.0 - tcosb - tsinb)
					+ (2.0 * tsinb * tcosa)) / 4.0.
	coeffs at: 2 put: ((1.0 - tcosa + tsina) * (1.0 + tcosb - tsinb)
					- (2.0 * tsinb * tcosa)) / 4.0.

	"precalculate cosine and sine of alpha minus beta"
	tcosa := (alpha - beta) cos.
	tsina := (alpha - beta) sin.

	"calculate last four wavelet coefficients c := a(0), d := a(1), e := a(2), and f := a(3)"
	coeffs at: 3 put: (1.0 + tcosa + tsina) / 2.0.
	coeffs at: 4 put: (1.0 + tcosa - tsina) / 2.0.
	coeffs at: 5 put: 1.0 - (coeffs at: 1) - (coeffs at: 3).
	coeffs at: 6 put: 1.0 - (coeffs at: 2) - (coeffs at: 4).

	"MakeFiltersFromCoeffs..."
	"Select the non-zero wavelet coefficients"
	coeffs := coeffs copyFrom: (coeffs findFirst: [:c | c abs > 1.0e-14])
						to: (coeffs findLast: [:c | c abs > 1.0e-14]).

	"Form the low pass and high pass filters for decomposition"
	hTilde := coeffs reversed collect: [:c | c / 2.0].
	gTilde := coeffs collect: [:c | c / 2.0].
	1 to: gTilde size by: 2 do:
		[:i | gTilde at: i put: (gTilde at: i) negated].

	"Form the low pass and high pass filters for reconstruction"
	h := coeffs copy.
	g := coeffs reversed.
	2 to: g size by: 2 do:
		[:i | g at: i put: (g at: i) negated]
