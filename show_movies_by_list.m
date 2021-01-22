function show_movies_by_list(movielist,genres)
    for i=1:length(movielist)
        toPrint="";
        
        tmpgen=[];
        name=movielist{i,1};
        for k=2:length(genres)
           if movielist{i,k}
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