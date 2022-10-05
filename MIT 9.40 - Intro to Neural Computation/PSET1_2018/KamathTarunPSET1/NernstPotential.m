function E = NernstPotential(Cin, Cout,z,T)
%NERNSTPOTENTIAL: Computes Nernst potential at specified T in celsius
%
% Input Arguments:
% Cin: internal ionic concteration
% Cout: external ionic concentation
% z: ion valence (with sign)
% T : temperature in degres Celsius
%
% Output:
% E: Nernst potential in mV
%
% Note : Cin are Cout need to be in the same units
k = physconstant('Boltzmann');
fraction = k*(T+273.15)/(z*1.6e-19);
ratio = Cin/Cout;

E = 1000 * fraction * log(ratio)
