function safeWorldfile(worldfile, pathToWorldfile)

fileID = fopen(pathToWorldfile,'w');
fprintf(fileID,'%f15\n',worldfile);
fclose(fileID);

end