processing
setCurrentFrame: aKlattFrame
	| ampFNV ampFTV ampF1V ampF2V ampF3V ampF4V ampF2F ampF3F ampF4F ampF5F ampF6F |
	<returnTypeC: 'void'>
	<var: 'aKlattFrame' type: 'float *'>
	<var: 'ampFNV' type: 'float '>
	<var: 'ampFTV' type: 'float '>
	<var: 'ampF1V' type: 'float '>
	<var: 'ampF2V' type: 'float '>
	<var: 'ampF3V' type: 'float '>
	<var: 'ampF4V' type: 'float '>
	<var: 'ampF2F' type: 'float '>
	<var: 'ampF3F' type: 'float '>
	<var: 'ampF4F' type: 'float '>
	<var: 'ampF5F' type: 'float '>
	<var: 'ampF6F' type: 'float '>

	frame := aKlattFrame.

	"Fudge factors..."
	ampFNV := (self linearFromdB: (frame at: Anv)) * 0.6.	"-4.44 dB"
	ampFTV := (self linearFromdB: (frame at: Atv)) * 0.6.		"-4.44 dB"
	ampF1V := (self linearFromdB: (frame at: A1v)) * 0.4.		"-7.96 dB"
	ampF2V := (self linearFromdB: (frame at: A2v)) * 0.15.	"-16.5 dB"
	ampF3V := (self linearFromdB: (frame at: A3v)) * 0.06.	"-24.4 dB"
	ampF4V := (self linearFromdB: (frame at: A4v)) * 0.04.	"-28.0 dB"
	ampF2F := (self linearFromdB: (frame at: A2f)) * 0.15.		"-16.5 dB"
	ampF3F := (self linearFromdB: (frame at: A3f)) * 0.06.	"-24.4 dB"
	ampF4F := (self linearFromdB: (frame at: A4f)) * 0.04.	"-28.0 dB"
	ampF5F := (self linearFromdB: (frame at: A5f)) * 0.022.	"-33.2 dB"
	ampF6F := (self linearFromdB: (frame at: A6f)) * 0.03.	"-30.5 dB"

	"Set coefficients of variable cascade resonators"
	cascade >= 8
		ifTrue: [samplingRate >= 16000	"Inside Nyquist rate?"
					ifTrue: [self resonator: R8c frequency: 7500 bandwidth: 600]
					ifFalse: [cascade := 6]].
	cascade >= 7
		ifTrue: [samplingRate >= 16000	"Inside Nyquist rate?"
					ifTrue: [self resonator: R7c frequency: 6500 bandwidth: 500]
					ifFalse: [cascade := 6]].
	cascade >= 6 ifTrue: [self resonator: R6c frequency: (frame at: F6) bandwidth: (frame at: B6)].
	cascade >= 5 ifTrue: [self resonator: R5c frequency: (frame at: F5) bandwidth: (frame at: B5)].
	self resonator: R4c frequency: (frame at: F4) bandwidth: (frame at: B4).
	self resonator: R3c frequency: (frame at: F3) bandwidth: (frame at: B3).
	self resonator: R2c frequency: (frame at: F2) bandwidth: (frame at: B2).
	self resonator: R1c frequency: (frame at: F1) bandwidth: (frame at: B1).

	"Set coefficients of nasal and tracheal resonators and antiresonators"
	self resonator: Rnpc frequency: (frame at: Fnp) bandwidth: (frame at: Bnp).
	self resonator: Rtpc frequency: (frame at: Ftp) bandwidth: (frame at: Btp).
	self antiResonator: Rnz frequency: (frame at: Fnz) bandwidth: (frame at: Bnz).
	self antiResonator: Rtz frequency: (frame at: Ftz) bandwidth: (frame at: Btz).

	"Set coefficients of parallel resonators, and amplitude of outputs"
	self resonator: Rnpp frequency: (frame at: Fnp) bandwidth: (frame at: Bnp) gain: ampFNV.
	self resonator: Rtpp frequency: (frame at: Ftp) bandwidth: (frame at: Btp) gain: ampFTV.
	self resonator: R1vp frequency: (frame at: F1) bandwidth: (frame at: B1) gain: ampF1V.
	self resonator: R2vp frequency: (frame at: F2) bandwidth: (frame at: B2) gain: ampF2V.
	self resonator: R3vp frequency: (frame at: F3) bandwidth: (frame at: B3) gain: ampF3V.
	self resonator: R4vp frequency: (frame at: F4) bandwidth: (frame at: B4) gain: ampF4V.
	self resonator: R2fp frequency: (frame at: F2) bandwidth: (frame at: B2f) gain: ampF2F.
	self resonator: R3fp frequency: (frame at: F3) bandwidth: (frame at: B3f) gain: ampF3F.
	self resonator: R4fp frequency: (frame at: F4) bandwidth: (frame at: B4f) gain: ampF4F.
	self resonator: R5fp frequency: (frame at: F5) bandwidth: (frame at: B5f) gain: ampF5F.
	self resonator: R6fp frequency: (frame at: F6) bandwidth: (frame at: B6f) gain: ampF6F