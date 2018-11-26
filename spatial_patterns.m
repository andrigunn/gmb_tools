clear all, close all, clc
cd('/Users/andrigun/Dropbox/glac_mass/grd')
cd('bw')


%%
b=dir('*.asc')
b = rmfield(b, {'folder', 'date', 'bytes', 'isdir', 'datenum'});
        %%
        ki=0
for i = 1:length(b)
    ki = ki+1
%     figure
%     [Z,R] = arcgridread(b(i).name);     % Read in DEM for ICELAND
%     mapshow(Z,R,'DisplayType','surface')
%     xlabel('x (easting in meters)')
%     ylabel('y (northing in meters)')
%     %demcmap(jet)
%     colorbar
%     shading flat
    b(ki).year = str2num(b(i).name(end-7:end-4))
end

year = [b(:).year];
year = sort(year(:))
for i = 1:length(year)
    iy = find([b.year] == year(i))
    B(i).year = year(i)
    B(i).name = b(iy).name
end

clear b
%%
clear S
ki = 0
for i = 5:length(B)
    ki = ki+1;
     [Z,R] = arcgridread(B(i).name); 
     S(:,:,ki) = Z;

end
%% Mean
    figure
    mapshow(mean(S,3),R,'DisplayType','surface')
    xlabel('x (easting in meters)')
    ylabel('y (northing in meters)')
    %demcmap(jet)
    cmap =cbrewer('seq','Blues', 10);
    colorbar
    colormap(cmap)
    shading flat

%% Trend
ss = size(S)
t = ss(3)
trendmap = trend(S,t,3)

    figure
    mapshow(trendmap,R,'DisplayType','surface')
    xlabel('x (easting in meters)')
    ylabel('y (northing in meters)')
    %demcmap(jet)
    cmap =cbrewer('div','RdBu', 100);
    colorbar
    colormap(cmap)
    shading flat