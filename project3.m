%%Ionospheric Radio
d1 = load('DA230805210000_000.mat');
d2 = load('DA230805220000_000.mat');

%concatenating 
raw = [double(d1.data); double(d2.data)];
Fs = d1.Fs; 