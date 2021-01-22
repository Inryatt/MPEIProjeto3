%% Criação da cell dos filmes
moviesData = readcell("u_item.txt");
genres=["","unknown","Action","Adventure","Animation","Children's",...
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
clc;
k = 50;

%% 
minHash = createMinHash(u,k);
% gera a minHash entre a relação users/movies
%%
shinglesMinHash = createShinglesMinHash(ns, k, moviesData, movies);
% gera a minHash entre a relação movies/shingles
%% teste min (apagar depois)
a = [12 13 15 8]; 
b = [8 15 7 9];
min(a,b); % --> [8 13 7 8];

%% Menu
clc;
% Pedir o user ID ao utilizador
userid=get_user();
choice=0;

while choice ~= 4
    fprintf("\n1 - Your Movies\n2 - Get Suggestions\n3 - Search Title\n4 - Exit\n\n");
    choice = get_choice();       
    switch choice
        case 1 
            % Mostrar filmes vistos pelo utilizador
            show_movies(userid,u,moviesData,genres);
        
        case 2
            genre=get_genre(); % pede ao utilizador para escolher o género pretendido64
            
            distancias = compareUsers(userid, users, minHash);
            [distancia,userMaisProx] = min(distancias); % obtém-se o utilizador mais similar a nós
            
            userMaisProx_movies=get_movies(userMaisProx,udata); % obtém-se os ids dos filmes vistos pelo utilizador mais próximo
            user_movies=get_movies(userid,udata); % obtém-se os ids dos filmes do nosso utilizador
            unwatched_movies=setdiff(userMaisProx_movies,user_movies); % obtém-se os filmes vistos pelo userMaisProx que nao tenham 
            unwatched_movies=moviesData(unwatched_movies,:); % Passar os ids dos filmes à informação referente a cada um
            
            print_by_genre(unwatched_movies,genre);
            
            
            
        case 3
            dist2 = search(shinglesMinHash, ns, k, n_movies);
            [distancia,pos] = mink(dist2,5);
            for i=1:5
                if distancia(i) <= 0.99 % print se <= 0.99
                    m = moviesData(pos(i));
                    fprintf("%40s \t\t %5f\n",m{1},distancia(i));
                end
            end
    
    end
    
end

disp("Goodbye! :)");
clear choice;

%% Functions

% Inicialização do user
function userid=get_user()
    userid = input("Insert User ID (1 to 943): ");

    while floor(userid) ~= userid || userid < 1 || userid > 943
        userid = input("ID must be a integer! (1 to 943): ");
    end
end

function choice=get_choice()
    choice = input("Select choice: " );

    while floor(choice) ~= choice || choice < 1 || choice > 4
        choice = input("Choice must be a integer! (1 to 4): ");
    end
    newline;
end

function genre=get_genre()
    genres=["unknown","Action","Adventure","Animation","Children's",...
    "Comedy", "Crime","Documentary","Drama","Fantasy","Film-Noir",...
    "Horror","Musical","Mystery","Romance","Sci-Fi","Thriller","War","Western"];

    fprintf("1- Action   2- Adventure  3- Animation   4- Children’s\n5- Comedy   6- Crime      7- Documentary 8- Drama\n9- Fantasy  10- Film-Noir 11- Horror     12- Musical\n13- Mystery 14- Romance   15- Sci-Fi     16- Thriller\n17- War     18- Western\n\n");
    genre = input("Select genre: " );
        
    while floor(genre) ~= genre || genre < 1 || genre > 18
        genre = input("Choice must be a integer! (1 to 18): ");
    end
    genre=genre+1;
    fprintf("Selected genre: %s\n",genres(genre));
    newline;

end