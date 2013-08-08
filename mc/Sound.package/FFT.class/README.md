This class implements the Fast Fourier Transform roughly as described on page 367
of "Theory and Application of Digital Signal Processing" by Rabiner and Gold.
Each instance caches tables used for transforming a given size (n = 2^nu samples) of data.

It would have been cleaner using complex numbers, but often the data is all real.