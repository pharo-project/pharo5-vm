processing
cascadeBranch: source
	"Cascade vocal tract, excited by laryngeal sources.
	Nasal antiresonator, nasal resonator, tracheal antirresonator,
	tracheal resonator, then formants F8, F7, F6, F5, F4, F3, F2, F1."
	| out |
	<inline: true>
	<returnTypeC: 'float'>
	<var: 'source' type: 'float '>
	<var: 'out' type: 'float '>
	cascade > 0 ifFalse: [^ 0.0].
	out := self antiResonator: Rnz value: source.
	out := self resonator: Rnpc value: out.
	out := self antiResonator: Rtz value: out.
	out := self resonator: Rtpc value: out.
	"Do not use unless sample rate >= 16000"
	cascade >= 8 ifTrue: [out := self resonator: R8c value: out].
	"Do not use unless sample rate >= 16000"
	cascade >= 7 ifTrue: [out := self resonator: R7c value: out].
	"Do not use unless long vocal tract or sample rate increased"
	cascade >= 6 ifTrue: [out := self resonator: R6c value: out].
	cascade >= 5 ifTrue: [out := self resonator: R5c value: out].
	cascade >= 4 ifTrue: [out := self resonator: R4c value: out].
	cascade >= 3 ifTrue: [out := self resonator: R3c value: out].
	cascade >= 2 ifTrue: [out := self resonator: R2c value: out].
	cascade >= 1 ifTrue: [out := self resonator: R1c value: out].
	^ out