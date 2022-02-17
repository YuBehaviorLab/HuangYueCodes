function [x_pos,y_pos] = find_pos(path)

dir_name = path;
k = 1000;
while k<180000
    img = imread(fullfile(dir_name,[path(end-16:end),'.',num2str(k,'%06d'),'.jpg']));
    h = figure;
    imshow(img);
    tmp = input('��������1����   2�����0.25s   �س������2s\n');
    close;
    if tmp == 1
        break
    elseif tmp == 2
        k = k-175;
    end
    k = k+200;
end
filename = fullfile(dir_name,[path(end-16:end),'.',num2str(k,'%06d'),'.jpg']);
disp('��ֱ����Ƶ����ϽǺ����½�')
while 1

h = figure();
img = imread(filename);
imshow(img);
x_lim = get(gca,'Xlim');
y_lim = get(gca,'Ylim');

[h, l] = size(img);

[x_tmp,y_tmp] = ginput(2);
close;

x = round(y_tmp-0.5);
y = round(x_tmp-0.5);
figure;
img(x(1)+(-1:1),y(1):y(2)) = uint8(255);
img(x(2)+(-1:1),y(1):y(2)) = uint8(255);
img(x(1):x(2),y(1)+(-1:1)) = uint8(255);
img(x(1):x(2),y(2)+(-1:1)) = uint8(255);
imshow(img);
temp = input('�Ƿ���ʣ�1����   2����\n');
close;
if temp == 1
    x_pos = x;
    y_pos = y;
    break
end

end
end