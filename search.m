function search(movies)
    % Maneira sem o minHash bla
    name = input("Write a string: ", 's');
    C1 = unique(strsplit(lower(name)));
    distancias = zeros(1, size(movies,1));
    for i=1:size(movies,1)
        filme = movies{i,1};
        C2 = unique(strsplit(lower(filme)));
        distancias(i) = 1 - (length(intersect(C1,C2))/length(union(C1,C2)));
        % distancia de Jaccard
    end
    [mi,index] = mink(distancias,5); 
    % as 5 menores distancias e seus indices
    for i = 1:5
        if mi(i) > 0.99 % não mostrar se a distancia for > 0.99
            if i == 1
                disp("We don't have nothing like that :(");
            end
            break
        end
        fprintf(distancias(index(i)) + " | " + movies{index(i),1} + "\n");
    end
end

