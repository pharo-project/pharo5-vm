frame parameter data
parameterData
	"This is a table describing the Klatt parameters. The columns are: parameter name, minimum value, maximum, parameter description, unit."
	^ #(
	"Excitation source (voice, aspiration and friction):"
		(f0 20 1000 'Fundamental frequency (hz)' hz)
		(flutter 0 1 'Amount of flutter' value)
		(jitter 0 1 'Amount of jitter' value)
		(shimmer 0 1 'Amount of shimmer' value)
		(diplophonia 0 1 'Amount of diplophonia' value)
		(voicing 0 80 'Amplitude of voicing' hz)
		(ro 0.01 1 'Relative duration of open phase of voicing waveform = Te/T0 (0.01 - 1)' value)
		(ra 0.01 0.2 'Relative duration of return phase of voicing waveform = Ta/T0 (0.01 - 1)' value)
		(rk 0.01 1 'Simmetry of the glottal pulse = (Te-Tp)/Tp (0.01 - 1)' value)
		(aspiration 0 80 'Amplitude of aspiration' dB)
		(friction 0 80 'Amplitude of friction' dB)
		(turbulence 0 80 'Amplitude of turbulence (in open glottal phase)' dB)

	"Formants frequencies and bandwidths:"	
		(f1 200 1300 'Frequency of 1st formant' hz)
		(b1 40 1000 'Bandwidth of 1st formant' hz)
		(df1 0 100 'Change in F1 during open portion of period' hz)
		(db1 0 400 'Change in B1 during open portion of period' hz)
		(f2 550 3000 'Frequency of 2nd formant' hz)
		(b2 40 1000 'Bandwidth of 2nd formant' hz)
		(f3 1200 4999 'Frequency of 3rd formant' hz)
		(b3 40 1000 'Bandwidth of 3rd formant' hz)
		(f4 1200 4999 'Frequency of 4th formant' hz)
		(b4 40 1000 'Bandwidth of 4th formant' hz)
		(f5 1200 4999 'Frequency of 5th formant' hz)
		(b5 40 1000 'Bandwidth of 5th formant' hz)
		(f6 1200 4999 'Frequency of 6th formant' hz)
		(b6 40 1000 'Bandwidth of 6th formant' hz)
		(fnp 248 528 'Frequency of nasal pole' hz)
		(bnp 40 1000 'Bandwidth of nasal pole' hz)
		(fnz 248 528 'Frequency of nasal zero' hz)
		(bnz 40 1000 'Bandwidth of nasal zero' hz)
		(ftp 300 3000 'Frequency of tracheal pole' hz)
		(btp 40 1000 'Bandwidth of tracheal pole' hz)
		(ftz 300 3000 'Frequency of tracheal zero' hz)
		(btz 40 2000 'Bandwidth of tracheal zero' hz)

	"Parallel Friction-Excited:"
		(a2f 0 80 'Amplitude of friction-excited parallel 2nd formant' dB)
		(a3f 0 80 'Amplitude of friction-excited parallel 3rd formant' dB)
		(a4f 0 80 'Amplitude of friction-excited parallel 4th formant' dB)
		(a5f 0 80 'Amplitude of friction-excited parallel 5th formant' dB)
		(a6f 0 80 'Amplitude of friction-excited parallel 6th formant' dB)
		(bypass 0 80 'Amplitude of friction-excited parallel bypass path' dB)
		(b2f 40 1000 'Bandwidth of friction-excited parallel 2nd formant' hz)
		(b3f 60 1000 'Bandwidth of friction-excited parallel 2nd formant' hz)
		(b4f 100 1000 'Bandwidth of friction-excited parallel 2nd formant' hz)
		(b5f 100 1500 'Bandwidth of friction-excited parallel 2nd formant' hz)
		(b6f 100 4000 'Bandwidth of friction-excited parallel 2nd formant' hz)

	"Parallel Voice-Excited:"
		(anv 0 80 'Amplitude of voice-excited parallel nasal formant' dB)
		(a1v 0 80 'Amplitude of voice-excited parallel 1st formant' dB)
		(a2v 0 80 'Amplitude of voice-excited parallel 2nd formant' dB)
		(a3v 0 80 'Amplitude of voice-excited parallel 3rd formant' dB)
		(a4v 0 80 'Amplitude of voice-excited parallel 4th formant' dB)
		(atv 0 80 'Amplitude of voice-excited parallel tracheal formant' dB)

	"Overall gain:"
		(gain 0 80 'Overall gain' dB))