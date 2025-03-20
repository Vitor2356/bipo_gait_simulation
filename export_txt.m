fid = fopen('SMC_2_Ut.txt','wt');
for ii = 1:size(Ut,1)
    fprintf(fid,'%g\t',Ut(ii,:));
    fprintf(fid,'\n');
end
fclose(fid)