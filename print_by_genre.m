function print_by_genre(movies,genre)  
    matches=0; %inicialização do contador
    siz = size(movies);
    for i=1:siz
        if movies{i,(genre)}==1 % se o filme pertencer ao género escolhido
            fprintf("%s\n",movies{i,1}); % é impresso
            matches=matches+1; % e aumenta-se o número de filmes encontrados
        end
    end
            
    if matches==0 % se o utilizador mais parecido não tiver visto nenhum filme do género pretendido
               % é impressa a seguinte mensagem: 
    disp("Não temos nenhuma sugestão para o género escolhido! :( "); 
    end
end