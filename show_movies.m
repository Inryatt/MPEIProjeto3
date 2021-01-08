function show_movies(userid,udata,movies,genres)
    tmp=udata(:,1)== userid; 
    uinfo=udata(tmp,:);
    movieid=uinfo(:,2);
    for i=1:length(movieid)
        toPrint="";
        name="";
        tmpgen=[];
        name=movies{i,1};
        for k=2:length(genres)
           if movies{i,k}
               tmpgen=[tmpgen genres(k)]  ;              
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