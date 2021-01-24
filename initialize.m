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

    %% OBSERVAÇÃO: FAZER EM UM SCRIPT A PARTE AS COISAS DE INICIALIZAÇÃO (VER NO GUIÃO OU CONFIRMAR COM O DIOGO :') )
    udata = load('u.data'); % Carrega o ficheiro dos dados dos filmes
    % Fica apenas com as duas primeiras colunas
    u= udata(1:end,1:2); 
    % u = user e filme que ele assistiu
    % Lista de utilizadores
    users = unique(u(:,1)); % Extrai os IDs dos utilizadores
    movies = unique(u(:,2));

    n_movies = length(unique(u(:,2))); 
    % verificar o número de filmes diferentes (tamanho máximo do array de filmes)

    ns = 3; % number of shingles
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