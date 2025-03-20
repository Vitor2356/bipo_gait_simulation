% if(totSims > 2)
%     figure(1)
%     for i=1:4
%         for j=1:(totSims-1)
%             subplot (4, (totSims-1), j + (i-1)*(totSims-1))
%             Lims = ylim;
%             if(j == 1)
%                 Ymin = Lims(1);
%                 Ymax = Lims(2);
%             else
%                 Ymin = min(Lims(1), Ymin);
%                 Ymax = max(Lims(2), Ymax);
%             end
%         end
%         for j=1:(totSims-1)
%             subplot (4, (totSims-1), j + (i-1)*(totSims-1))
%             ylim([Ymin, Ymax])
%         end
%     end
% end

for numFig = 2:5
    if(numFig ~= 4)
        figure(numFig)
        if(numFig == 4)
            numRows = 4;
        else
            numRows = 5;
        end
        for i=1:numRows
            for j=1:(totSims)
                subplot(numRows, (totSims), j + (i-1)*(totSims))
                Lims = ylim;
                if(j == 1)
                    Ymin = Lims(1);
                    Ymax = Lims(2);
                else
                    Ymin = min(Lims(1), Ymin);
                    Ymax = max(Lims(2), Ymax);
                end
            end
            for j=1:(totSims)
                subplot (numRows, (totSims), j + (i-1)*(totSims))
                ylim([Ymin, Ymax])
                if((numFig == 5) && ((i == 1) || (i == 2)))
                    ylim([-0.01, Ymax])
                end
            end
        end
    end
end