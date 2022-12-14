function rate=alphah(v)
% input: v: membrane potential in mV
% output: rate: rate constant in ms^-1
theta = (v+70)/20;
rate=100*exp(-theta);
end
