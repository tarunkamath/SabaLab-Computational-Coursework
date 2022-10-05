%Cell Parameters
function [V, I, t, spikes] = integratefiremodel(x) 

C = .201 ;        	   		% Capacitance in nF
R = 100;         	   		% Resistance in MegaOhm
Vrest = -70;      	   		% Leakage current reversal potential in mV


% Integration parameters

dt = .1;          		% integration time-step in ms
Tdur = 1000;       		% simulation total time in ms
V0 = -70;             		% initial condition in mV
k = ceil(Tdur/dt); 		% total number of iterations
V = zeros(k+1,1);  		% Voltage vector in mV
V(1)= V0;             		% assign to the first element of array V, the initial condition V0
EL = -75;               %The leak voltage of the neuron
Vthr = -50;             %The threshold voltage of the neuron
Vres = -70;             %The reset voltage of the neuron

% time vector

t = dt.*(0:k);     		% time vector in ms


% Current pulse parameters    

Tstart = 200;         		% curent pulse start time in ms
Tstop = 700;          		% curent pulse stop time in ms
Iamplitude = x;     		% current pulse amplitude in nA


I = zeros(k+1,1);  		% current vector in nA
I(t>=Tstart & t<Tstop,1) = Iamplitude; % Assign amplitude when current is on 

spikescounter = 0;
spikes = [];

% Integration with Exponential Euler loop
    for j = 1 : k
        Vinf = 	EL + R*I(j,1);  		% Update V infinity value at j iteration    
        V(j+1,1) = Vinf + (V(j,1) - Vinf)*exp(-dt/(R*C)); % Compute V at iteration j+1 with Exponential Euler rule  
        if V(j+1,1) >= Vthr
            V(j+1,1) = Vres; %Set the next voltage potential equal to the reset voltage when the threshold is reached, indicating an action potential
            spikescounter = spikescounter + 1;%Count the number of spikes that take place as an index for the array
            spikes(spikescounter,1) = (j-1)/100; %Input the spike times into the array 
        end
    end

end 
