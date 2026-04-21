%%Ionospheric Radio - Project 3
Fs = 100000; f0 = 24000; % sampling rate and NAA transmitter frequency (Hz)

% load entire 21:30-22:00 UTC file
raw = double(matGetVariable('DA230805213000_000.mat', 'data'));

% build time vector in seconds
t = (0:length(raw)-1)' / Fs;

% heterodyne mix down and lowpass filter at 200 Hz
[b, a] = butter(5, 200/(Fs/2), 'low');
filt = filter(b, a, real(raw .* exp(-1j*2*pi*f0*t)));

% average into 1 second bins
for i = 1:floor(length(filt)/Fs)
    amplitude_avg(i) = mean(abs(filt((i-1)*Fs+1:i*Fs)));
end

% UTC time axis - file starts at 21:30 UTC
t_utc = 21.5 + (0:length(amplitude_avg)-1)/3600;

plot(t_utc, 20*log10(amplitude_avg))
xlabel('UTC Hour'), ylabel('Amplitude (dB)')
title('NAA 24 kHz Amplitude - Aug 5 2023')
xline(21.75, 'r--', 'X1.6 Flare start 21:45 UTC (NOAA)')
xline(21.92, 'b--', 'VLF response onset ~21:55 UTC')
grid on