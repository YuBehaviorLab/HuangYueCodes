clear;
load('timestamps.mat')
% load('G:\WHBWork\Ephys\Urey\Sessions\20211126\RTarrayAll_post.mat')
load('C:/Users/jiumao/Desktop/Urey20211124/RTarrayAll.mat')
%load('G:\WHBWork\Ephys\Urey\Sessions\20210929\PSTHOut.mat')
% ts = ts_pre;
%%
fr = 10;

indframe = find(strcmp(r.Behavior.Labels, 'FrameOn'));
t_frameon = r.Behavior.EventTimings(r.Behavior.EventMarkers == indframe);

ind_break = find(diff(t_frameon)>1000);
t_seg =[];
if isempty(ind_break)
    t_seg{1} = t_frameon;
else
    ind_break = [1; ind_break+1];
    for i =1:length(ind_break)
        if i<length(ind_break)
            t_seg{i}=t_frameon(ind_break(i):ind_break(i+1)-1);
        else
            t_seg{i}=t_frameon(ind_break(i):end);
        end
    end
end

for k = 1:length(ts.side)
    r_len = length(t_seg{k});
    
    diff_top = diff(ts.top(k).ts);
    diff_top = round(diff_top/10-1);
    ind_top = 1:length(ts.top(k).ts);
    for j = 1:length(diff_top)
        if r_len >= 120000
            break;
        elseif j==1
            continue;
        end
        if diff_top(j)>0
            ind_top(j:end) = ind_top(j:end) + diff_top(j);
        end
    end
    disp(ind_top(end))
    
    new_topframe_inds{k} = ind_top; 
    
    diff_side = diff(ts.side(k).ts);
    diff_side = round(diff_side/10-1);
    ind_side = 1:length(ts.side(k).ts);
    for j = 1:length(diff_side)
        if r_len >= 120000
            break;
        elseif j==1
            continue;
        end
        if diff_side(j)>0
            ind_side(j:end) = ind_side(j:end) + diff_side(j);
        end
    end
    
    new_sideframe_inds{k} = ind_side; 
    disp(ind_side(end))
end
%%
new_sideframe_inds={1:120000,1:119999};
new_topframe_inds={1:119999,1:119999};
r = UpdateRFrameSignal(r, 'time_stamps', ts, 'sidevideo_ind', new_sideframe_inds,'topvideo_ind', new_topframe_inds);
%%
ExtractEventFrameSignalVideo(r, ts, [], 'events', 'Press', 'time_range', [2100 2400], 'makemov', 1, 'camview', 'top',...
    'make_video_with_spikes',true,'sort_by_unit',true,'frame_rate',10,'start_trial',220);
%%
mat_dir = './VideoFrames/MatFile';
output = dir([mat_dir,'/*.mat']);
filenames = {output.name};
filenames = sort(filenames);
for k = 1:length(filenames)
    temp_filename = [mat_dir,'/',filenames{k}];
    load(temp_filename);
    r.VideoInfos(k) = VideoInfo;
end
%
save('RTarrayAll.mat','r')