function exportToTxt(Matrix, Name)

    fileID = fopen(['../Vars/Matrixes/matrix', Name, '.txt'],'wt');
    
    
    imax = length(Matrix(1:end, 1));
    jmax = length(Matrix(1, 1:end));
    
    for j = 1:jmax
        for i = 1:imax
            fprintf(fileID, '%s(%d, %d) = %s;\n', Name, i, j, Matrix(i, j));
        end
        fprintf(fileID, '\n');
    end
    
    fclose(fileID);
end