clear
load('./RTarrayAll.mat')
dlc_path = 'A:\Ephys\DLC\Eli-HY-2021-10-07';
data_path = './VideoFrames/RawVideo';
mat_path = './VideoFrames/MatFile';
%%
output_csv = dir([data_path,'/*.csv']);
filenames_csv = sort({output_csv.name});
output_mat = dir([mat_path,'/*.mat']);
filenames_mat = sort({output_mat.name});
for n = 1:length(filenames_csv)
    load([mat_path,'/',filenames_mat{n}]);
    [data,txt,~] = xlsread([data_path,'/',filenames_csv{n}]);
    bodyParts = cell(round((size(txt,2)-1)/3),1);
    coordinates_x = cell(length(bodyParts),1);
    coordinates_y = cell(length(bodyParts),1);
    coordinates_p = cell(length(bodyParts),1);
    for k = 1:length(bodyParts)
        bodyParts{k} = txt{2,3*k-1};
        coordinates_x{k} = data(:,3*k-1);
        coordinates_y{k} = data(:,3*k);
        coordinates_p{k} = data(:,3*k+1);
    end

    p_threshold = 0.9;

    firstFrames = cell(length(bodyParts),1);
    for k = 1:length(bodyParts)
        firstFrames{k} = find(coordinates_p{k}>p_threshold,1,'first');
    end
    
    Tracking.NetworkInformation = dlc_path;
    Tracking.BodyParts = bodyParts;
    Tracking.Coordinates_x = coordinates_x;
    Tracking.Coordinates_y = coordinates_y;
    Tracking.Coordinates_p = coordinates_p;
    Tracking.p_threshold = p_threshold;
    Tracking.FirstFrames = firstFrames;
    VideoInfo.Tracking = Tracking;
    VideoInfos(n) = VideoInfo;
    disp(n)
    save([data_path,'/',filenames_csv{n}],'VideoInfo');
end

r.VideoInfos = VideoInfos;
save('./RTarrayAll.mat','r')
