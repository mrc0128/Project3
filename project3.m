%%Ionospheric Radio
%d1 = load('DA230805210000_000.mat');
%d2 = load('DA230805220000_000.mat');

%concatenating 
%raw = [double(d1.data); double(d2.data)];
%Fs = d1.Fs; %sampling rate from mat file

%fid = fopen("DA230805210000_000.mat", 'rb');
%fseek(fid, -60000000, 'eof');
raw1 = matGetVariable('DA230805210000_000.mat', 'data');
disp('please')
%fclose(fid);

%fid = fopen("DA230805220000_000.mat", 'rb');
raw2 = matGetVariable('DA230805220000_000.mat', 'data');
%fclose(fid);
disp('close')

Fs = 100000;
raw = double([raw1; raw2]);
disp('oh no my pc')


%mixing down

f0 = 24000;
t = (0:length(raw)-1)' / Fs;
mixed = raw .* exp(-1j * 2*pi*f0*t);


N = 100000;
Y = fft(real(mixed(1:N)), N);
f = (0:N-1) * Fs / N;
plot(f/1000, abs(Y))
xlim([0 2])
xlabel('kHz')
ylabel('Magnitude')
title('mixed down')