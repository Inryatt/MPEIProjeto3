function distancias = compareUsers(user,users,minHash)
    N = length(users);
    k = size(minHash,1);
    distancias = ones(1, N); 
    % vetor que guardará a distancia de Jaccard de todos os users em
    % relação ao user escolhido
    
    for u=1:N
        if u ~= user 
            % considerar o user tendo distância 1 (se não, ele sempre iria
            % ser considerado a menor distância para ele mesmo)
            distancias(u) = 1 - sum(minHash(:,user) == minHash(:,u))/k;
        end
    end
    
end

