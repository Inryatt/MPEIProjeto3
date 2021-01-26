function initi=initialize()
    
    
    initi=0;
    disp("Initializing, please wait...");
    %% Criação da cell dos filmes
    moviesData = readcell("u_item.txt");
    genres=["","unknown","Action","Adventure","Animation","Children's",...
        "Comedy", "Crime","Documentary","Drama","Fantasy","Film-Noir",...
        "Horror","Musical","Mystery","Romance","Sci-Fi","Thriller","War",...
        "Western"];
    % coluna 1 é o nome do filme e as colunas 2 - 20 são os gêneros do filme,
    % que podem ser:                            11 - Fantasy
    % 2 - unknown                               12 - Film-Noir
    % 3 - Action                                13 - Horror
    % 4 - Adventure                             14 - Musical
    % 5 - Animation                             15 - Mystery
    % 6 - Children's                            16 - Romance
    % 7 - Comedy                                17 - Sci-Fi
    % 8 - Crime                                 18 - Thriller
    % 9 - Documentary                           19 - War                      
    % 10 - Drama                                20 - Western

    %% Importar informação externa 
    % 1a coluna - user ID
    % 2a coluna - movie ID
    % 3a coluna - rating (1 a 5)

    udata = load('u.data'); % Carrega o ficheiro dos dados dos filmes
    % Fica apenas com as duas primeiras colunas
    u= udata(1:end,1:2); 
    % u = user e filme que ele assistiu
    % Lista de utilizadores
    users = unique(u(:,1)); % Extrai os IDs dos utilizadores
    movies = unique(u(:,2));

    n_movies = length(unique(u(:,2))); 
    % verificar o número de filmes diferentes (tamanho máximo do array de filmes)

    ns = 4; % number of shingles
    %% criar as minHashs

    k = 150;

    %% 
    minHash = createMinHash(u,k);
    % gera a minHash entre a relação users/movies
    %%
    shinglesMinHash = createShinglesMinHash(ns, k, moviesData, movies);
    % gera a minHash entre a relação movies/shingles
    initi='done';
    save('initialization');
end

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
    for count=1:nUsers
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

    end
end

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

function h= alt_DJB31MA(chave, seed, k)
% implementação da hash function DJB31MA com base no algoritmo obtido
% no resumo 2014(PJF) que está em C
%
%  chave    array de caracteres com a chave
%  seed     semente que permite obter vários hash codes para a mesma chave
%   k       número de hashfunctions
%   h        hashcode devolvido
len= length(chave);
chave= double(chave);
val= seed;
for i=1:len
    val = mod(31 * val + chave(i), 2^32 -1) ;
end

h = zeros(k,1);

for i=1:5 
    % evitar que o primeiro valor seja um valor pequeno (5 parece o ideal)
    val = mod(31 * val(1) + num2str(i), 2^32 -1);
end

for i=1:k % adicionar cada hashfunction na matrix
    val = mod(31 * val(1) + num2str(i), 2^32 -1);
    h(i) = val(1);
end
end


function [shingles,n_sh] = getShingles(str,ns)
    N = strlength(str);
    n_sh = N-ns+1; 
    % number of shingles (sem ignorar diferentes) que vão ter na string
    shingles = cell(1,n_sh);
    
    
    for ch=1:n_sh
        shingles{ch} = str(ch:ch+ns-1);
    end
    
    shingles = unique(shingles); % ignorar shingles iguais
    n_sh = length(shingles);
    
end

