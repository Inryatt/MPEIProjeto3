function print_recs(recs,genres) 
    disp("Recomendações:");
    recs
    for i=1:length(recs)
        name=recs{i,1};
        toPrint="";
        for k=2:length(genres)
            if recs{i,k}
                tmpgen=[tmpgen genres(k)];              
            end
        end
        toPrint=append(toPrint,sprintf("%-70s",name));
        for a=1:length(tmpgen)
            toPrint=append(toPrint,sprintf("| %-15s",tmpgen(a)));
        end
        disp(toPrint);
        newline;   
    end
end