%%Ionospheric Radio
%d1 = load('DA230805210000_000.mat');
%d2 = load('DA230805220000_000.mat');

%concatenating 
%raw = [double(d1.data); double(d2.data)];
%Fs = d1.Fs; %sampling rate from mat file

fid = fopen("DA230805210000_000.mat", 'rb');
raw1 = fread(fid, inf, 'int16');
fclose(fid);

fid = fopen("DA230805220000_000.mat", 'rb');
raw2 = fread(fid, inf, 'int16');
fclose(fid);
disp('close')

Fs = 100000;
raw = double([raw1; raw2]);
disp('oh no my pc')


%mixing down

f0 = 24000;
t = (0:length(raw)-1)' / Fs;
mixed = raw .* exp(-1j * 2*pi*f0*t);


%checking for spike near 0
pwelch(real(mixed(1:10000)), [], [], 2^16, Fs);

