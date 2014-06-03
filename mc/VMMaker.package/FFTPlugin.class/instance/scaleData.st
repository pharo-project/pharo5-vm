transforming
scaleData
	"Scale all elements by 1/n when doing inverse"
	| realN |
	<var: #realN type: 'float '>
	fftSize <= 1 ifTrue:[^nil].
	realN := self cCoerce: (1.0 / (self cCoerce: fftSize to: 'double')) to: 'float'.
	0 to: fftSize-1 do:
		[:i |
		realData at: i put: (realData at: i) * realN.
		imagData at: i put: (imagData at: i) * realN]