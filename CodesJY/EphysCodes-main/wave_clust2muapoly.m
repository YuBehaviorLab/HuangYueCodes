function wave_clust2muapoly(chname)

spkfile = dir(['times_polytrode' chname '.mat']);

spk = load(spkfile.name);



%   Temp                  1x1                     8  double               
%   cluster_class      9273x2                148368  double               
%   forced             9273x1                  9273  logical              
%   gui_status            1x1                 75380  struct               
%   inspk              9273x13               964392  double               
%   ipermut               1x9273              74184  double               
%   par                   1x1                  9035  struct               
%   spikes             9273x64              4747776  double   

cluster_ids =spk.cluster_class(:, 1);
cluster_times = spk.cluster_class(:, 2);

% ind_spikes_sorted = find(cluster_ids>0);
ind_spikes_sorted = 1:length(cluster_ids);

mua.Nspikes = length(ind_spikes_sorted);
mua.units = ind_spikes_sorted;
mua.waveforms = spk.spikes(ind_spikes_sorted, :);
mua.ts = cluster_times(ind_spikes_sorted);

mua.fname = ['times_polytrode' chname '.mat'];
mua.opt = [];
mua.header = '';
mua.val2volt = [1 1];
mua.ncontacts = 1;
mua.ts_spike = [1:size(spk.spikes, 2)]/30;
mua.otherchannels = {};
mua.sourcechannel = chname;

save(['mua_poly' chname], 'mua')

% jsimpleclust

%           Nspikes: 10000
%         waveforms: [10000×64 double]
%                ts: [10000×1 double]
%             fname: 'example_data.nst'
%               opt: []
%            header: '######## Neuralynx Data File Header�?↵## File Name F:\jvoigts\nt-a6\2012-05-24_03-23-08\ST15.nst�?↵## Time Opened (m/d/y): 5/24/2012  (h:m:s.ms) 3:23:8.985�?↵## Time Closed File was not closed properly�?↵-CheetahRev 5.5.1 �?↵�?↵-AcqEntName ST15�?↵-FileType Spike�?↵-RecordSize 176�?↵�?↵-HardwareSubSystemName AcqSystem1�?↵-HardwareSubSystemType Cheetah64�?↵-SamplingFrequency 30303�?↵-ADMaxValue 32767�?↵-ADBitVolts 1.21464e-008 1.21464e-008 �?↵�?↵-NumADChannels 2�?↵-ADChannel 6 7 �?↵-InputRange 398 398 �?↵-InputInverted True�?↵-AmpLowCut 300�?↵-AmpHiCut 6000�?↵-AmpGain 3138 3138 �?↵-DisabledSubChannels �?↵-WaveformLength 32�?↵-AlignmentPt 8�?↵-ThreshVal 60 60 �?↵-MinRetriggerSamples 10�?↵-SpikeRetriggerTime 300�?↵-DualThresholding False�?↵�?↵-Feature Peak 0 0 �?↵-Feature Peak 1 1 �?↵-Feature Vall'
%          val2volt: [1.2146e-08 1]
%         ncontacts: 2
%          ts_spike: [1×64 double]
%     otherchannels: {1×6 cell}