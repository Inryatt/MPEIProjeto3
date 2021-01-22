function show_movies(userid,udata,movies,genres)
    tmp=udata(:,1)== userid % aqui obtemos um array binário: 1 se a primeira coluna 
                            % tiver valor igual ao userid que pretendemos
    uinfo=udata(tmp,:); % tira-se as linhas em que temos 1s no array acima
    movieid=uinfo(:,2); % obtém-se os ids dos filmes vistos pelo utilizador
    for i=1:length(movieid)
        toPrint="";
        tmpgen=[];
        name=movies{i,1};
        for k=2:length(genres)
           if movies{i,k}
               tmpgen=[tmpgen genres(k)]  ; %por cada filme é gerado um array
                                            % temporário com os géneros
                                            % desse filme
           end
        end
        toPrint=append(toPrint,sprintf("%-70s",name)); % junta-se o nome á linha a imprimir
                                                       % no terminal
        for a=1:length(tmpgen)
           toPrint=append(toPrint,sprintf("| %-15s",tmpgen(a)));
           %acrescenta-se os géneros do filme associado, na mesma linha
        end
        disp(toPrint);
        newline;
        
    end
    
end