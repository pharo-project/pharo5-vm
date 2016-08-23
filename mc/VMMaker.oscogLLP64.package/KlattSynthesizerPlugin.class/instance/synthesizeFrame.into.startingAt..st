processing
synthesizeFrame: aKlattFrame into: buffer startingAt: startIndex
	| noise voice frictionNoise aspirationNoise glotout
	parGlotout source temp out
	index top
	voicing parVoicing turbulence friction aspiration bypass
	gain ampGain |

	<returnTypeC: 'void'>
	<var: 'aKlattFrame' type: 'float *'>
	<var: 'buffer' type: 'short *'>
	<var: 'noise' type: 'float '>
	<var: 'voice' type: 'float '>
	<var: 'frictionNoise' type: 'float '>
	<var: 'aspirationNoise' type: 'float '>
	<var: 'voicing' type: 'float '>
	<var: 'parVoicing' type: 'float '>
	<var: 'turbulence' type: 'float '>
	<var: 'friction' type: 'float '>
	<var: 'aspiration' type: 'float '>
	<var: 'bypass' type: 'float '>
	<var: 'glotout' type: 'float '>
	<var: 'parGlotout' type: 'float '>
	<var: 'source' type: 'float '>
	<var: 'gain' type: 'float '>
	<var: 'ampGain' type: 'float '>
	<var: 'out' type: 'float '>

	self setCurrentFrame: aKlattFrame.

	pitch > 0
		ifTrue: [voicing := self linearFromdB: (frame at: Voicing) - 7.
				parVoicing := self linearFromdB: (frame at: Voicing).
				turbulence := (self linearFromdB: (frame at: Turbulence)) * 0.1]
		ifFalse: [voicing := parVoicing := turbulence := 0.0].

	friction := (self linearFromdB: (frame at: Friction)) * 0.25.
	aspiration := (self linearFromdB: (frame at: Aspiration)) * 0.05.
	bypass := (self linearFromdB: (frame at: Bypass)) * 0.05.		"-26.0 dB"

	"Flod overall gain into output resonator (low-pass filter)"
	gain := (frame at: Gain) - 3.
	gain <= 0 ifTrue: [gain := 57].
	ampGain := self linearFromdB: gain.
	self resonator: Rout frequency: 0 bandwidth: samplingRate gain: ampGain.

	noise := nlast.
	index := startIndex.
	top := samplesPerFrame + startIndex - 1.
	[index <= top] whileTrue: [
		"Get low-passed random number for aspiration and friction noise"
		noise := (self nextRandom - 32768) asFloat / 4.0. "radom number between -8196.0 and 8196.0"

		"Tilt down noise spectrum by soft low-pass filter having
		 a pole near the origin in the z-plane."
		noise := noise + (0.75 * nlast).
		nlast := noise.

		"Amplitude modulate noise (reduce noise amplitude during second
		 half of glottal period) if voicing  simultaneously present."
		nper > nmod ifTrue: [noise := noise * 0.5].

		"Compute frictation noise"
		frictionNoise := friction * noise.

		"Compute voicing waveform."
		voice := self glottalSource.
		vlast := voice.

		"Add turbulence during glottal open phase.
		 Use random rather than noise because noise is low-passed."
		nper < nopen ifTrue: [voice := voice + (turbulence * (self nextRandom - 32768) asFloat / 4.0)].

		"Set amplitude of voicing."
		glotout := voicing * voice.
		parGlotout := parVoicing * voice.

		"Compute aspiration amplitude and add to voicing source."
		aspirationNoise := aspiration * noise.
		glotout := glotout + aspirationNoise.
		parGlotout := parGlotout + aspirationNoise.

		"Cascade vocal tract, excited by laryngeal sources.
		 Nasal antiresonator, nasal resonator, trachearl antirresonator,
		 tracheal resonator, then formants F8, F7, F6, F5, F4, F3, F2, F1."
		out := self cascadeBranch: glotout.

		"Voice-excited parallel vocal tract F1, F2, F3, F4, FNP and FTP."
		source := parGlotout.	"Source is voicing plus aspiration."
		out := out + (self parallelVoicedBranch: source).

		"Friction-excited parallel vocal tract formants F6, F5, F4, F3, F2,
		 outputs added with alternating sign. Sound source for other
		 parallel resonators is friction plus first difference of
		 voicing waveform."
		source := frictionNoise + parGlotout - glast.
		glast := parGlotout.
		out := (self parallelFrictionBranch: source) - out.

		"Apply bypas and output low-pass filter"
		out := bypass * source - out.
		out := self resonator: Rout value: out.
		temp := (out * ampGain) asInteger.
		temp < -32768 ifTrue: [temp := -32768].
		temp > 32767 ifTrue: [temp := 32767].
		buffer at: index - 1 put: temp.
		index := index + 1.
		samplesCount := samplesCount + 1]