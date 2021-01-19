function minHash = createShinglesMinHash(ns, k, moviesCell, moviesId) 
    % a minHash é suposta ser feita como a outra, porém cada coluna são
    % moviesId (ao invés dos users) e eles contém todos os shingles (ao
    % invés dos moviesId)
    
    moviesName = moviesCell(:,1);
    % conjunto de cells, com cada título do movie
    
    minHash = zeros(k,length(moviesId));
    % minHash vai ser uma matriz em que as linhas representam uma hash
    % function e as colunas representam cada movie
     
    for m=1:length(moviesId)
        movie = moviesName{m};
        [sh,count] = getShingles(movie,ns);

        hash = inf(k,1);
        for s=1:count
            tempHash(:,1) = alt_DJB31MA(sh{s},100,k); 
            % fazer as k hash functions para cada movie
            hash = min(hash, tempHash);
            % atualiza o valor da hash para conter o min para cada movie
        end
        minHash(:,m) = hash;
   
    end
end

