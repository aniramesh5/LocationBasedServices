function main()


worldfile= calcWorldfile('./data/fixPoints.csv');

safeWorldfile(worldfile, './data/boston_snippet.pgw');

geoshow('./data/boston_snippet.png')

end