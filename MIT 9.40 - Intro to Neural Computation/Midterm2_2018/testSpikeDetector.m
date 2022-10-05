function [PCD,FAR] = testSpikeDetector(detectedSpikeTimesS, actualSpikeTimesS)
%
% [PCD,FAR]=testSpikeDetector(detectedSpikeTimesMS, actualSpikeTimesMS)
%
%  routine to compute performance measures from actual spike times and
%  detected spike times.  Note, this only works in artificial situations
%  where one actually knows the actual spike times!   Written by JJ DiCarlo
%
%

JITTER_S = .002;      %% allow 2 ms of jitter

% first try to match up the two sets of spikes times.  
% Anything within JITTER_MS counts as a match (but only one spike should
% occur in that time frame!)


%% make sure both lists are in order 
detected = sort(detectedSpikeTimesS);
actual = sort(actualSpikeTimesS);

% remove any spikes with the same times (these count as false alarms)
temp = [detected -1];
detected = detected(find(diff(temp)~=0));

%% find matching spikes and mark as matched (trueDetects list)
trueDetects = [];
for sp =actual      %% look at each actual spike
    z = find( (detected >= sp-JITTER_S) & (detected <= sp+JITTER_S) );
    if (length(z)>0)    %% a spike was on the detected list nearby the actual time
        for i = z       %% check to make sure we have not already counted this one
            zz = find(trueDetects == detected(i));
            if (length(zz) == 0) %% this detect time has not been used as a trueDetect
                trueDetects = [trueDetects detected(i)];        %% add it to the list
                break;
            end
        end
    end
    
end

PCD = (length(trueDetects)/length(actualSpikeTimesS))*100.;


%% everything that was not a true detect is a false alarm
totalTimeSEC = (actual(end)-actual(1))/1000.;       %% this is only approximate, but fine for large files
FAR = (length(detectedSpikeTimesS) - length(trueDetects))/totalTimeSEC;

s = sprintf('Spike detector performance:');fprintf('\n%s\n',s);
s = sprintf('   Total actual spikes in voltage record = %s spikes',num2str(length(actualSpikeTimesS)));fprintf('%s\n',s);
s = sprintf('   Percentage Correct detection  = %s percent',num2str(PCD)); fprintf('%s\n',s);
s = sprintf('   False alarm rate = %s spikes/sec',num2str(FAR)); fprintf('%s\n',s);
fprintf('\n');




