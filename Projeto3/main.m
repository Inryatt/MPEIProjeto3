%% Criação da cell dos filmes
movies = readcell("u_item.txt");

movie_genre=["","unknown","Action","Adventure","Animation","Children's",...
    "Comedy", "Crime","Documentary","Drama","Fantasy","Film-Noir",...
    "Horror","Musical","Mystery","Romance","Sci-Fi","Thriller","War","Western"];
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

%% Catação do ID
% 1a coluna - user id
% 2a coluna - movie id
% 3a coluna - rating (1 a 5)


udata = load('u.data'); % Carrega o ficheiro dos dados dos filmes
% Fica apenas com as duas primeiras colunas
u= udata(1:end,1:2); clear udata;
% u = user e filme que ele assistiu
% Lista de utilizadores
users = unique(u(:,1)); % Extrai os IDs dos utilizadores

n_movies = length(unique(u(:,2))); 
% verificar o número de filmes diferentes (tamanho máximo do array de filmes)

%% Inicialização do user
userid = input("Insert User ID (1 to 943): ");


%%
testu=sort(u,1);
show_movies(38,u,movies,movie_genre);

