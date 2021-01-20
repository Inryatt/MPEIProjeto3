function distancias = search(shinglesMinHash,ns,k,n_movies)

    name = input("Write a string: ", 's');
    while strlength(name) < ns 
        % o nome tem de pelo menos ter comprimento >= numero de shingles
        disp("Input needs to be more than " + (ns-1) + " characters!");
        name = input("Write a string: ", 's');
    end
    
    [name_shingles,count] = getShingles(name,ns);

    
    namehash = inf(k,1);

    for s=1:count
        tempHash(:,1) = alt_DJB31MA(name_shingles{s},100,k); 
        % fazer as k hash functions para cada movie
        namehash = min(namehash, tempHash);
        % atualiza o valor da hash para conter o min para cada movie
    end
    distancias = ones(1,n_movies);
    
    for m=1:n_movies
        distancias(m) = 1 - sum(namehash == shinglesMinHash(:,m))/k;
    end
    
%%    Maneira de se fazer não utilizando minHashs
%     C1 = unique(strsplit(lower(name)));
%     distancias = zeros(1, size(movies,1));
%     for i=1:size(movies,1)
%         filme = movies{i,1};
%         C2 = unique(strsplit(lower(filme)));
%         distancias(i) = 1 - (length(intersect(C1,C2))/length(union(C1,C2)));
%         % distancia de Jaccard
%     end
%     [mi,index] = mink(distancias,5); 
%     % as 5 menores distancias e seus indices
%     for i = 1:5
%         if mi(i) > 0.99 % não mostrar se a distancia for > 0.99
%             if i == 1
%                 disp("We don't have nothing like that :(");
%             end
%             break
%         end
%         fprintf(distancias(index(i)) + " | " + movies{index(i),1} + "\n");
%     end
end

