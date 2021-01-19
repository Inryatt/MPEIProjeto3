function minHash = createMinHash(udata,k)
    % k = numero de hash functions
    % udata = informações dos users e usersids
    [users,posi] = sort(udata(:,1));
    movies = udata(posi,2);
    nUsers = length(unique(users));
    minHash = zeros(k,nUsers); 
    % minHash vai ser uma matriz em que as linhas representam uma hash
    % function e as colunas representam cada user
    
    % a forma que o minHash funciona: é feito uma hashfunction para cada id
    % de filmes de cada user, e então é pegado o menor valor. depois, para
    % comparar a semelhança de Jaccard entre 2 users, é feito uma 
    % comparação de quantos valores iguais eles tem na msm linha/numero de 
    % linhas.
    u = 1; % ponteiro/indice para o usuário
    count = 1; % conta o número de usuários
    while count <= nUsers
        nmovies = sum(users == users(u));
        user_movies = movies(u:u+nmovies-1); 
        % matriz que diz os ids dos filmes de cada user
        hash = inf(k,1); 
        % guarda o vetor dos min hash functions (começa no infinito)
        for mov=1:length(user_movies)
            tempHash(:,1) = alt_DJB31MA(user_movies(mov),100,k); 
            % fazer as k hash functions para cada movie
            hash = min(hash, tempHash);
            % atualiza o valor da hash para conter o min para cada movie
        end
        minHash(:,count) = hash;
        u = u + nmovies; % ignorar os outros users iguais
        count = count+1;
        
        % (ou seja, escolher o próximo utilizador)
    end
end

