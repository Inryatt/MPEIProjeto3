%% Criação da cell dos filmes
movies = readcell("u_item.txt");

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

while floor(userid) ~= userid || userid < 1 || userid > 943
    userid = input("ID must be a integer! (1 to 943): ");
end
choice = 0;
while choice ~= 4
    choice = showMenu(movies);
end

disp("Goodbye! :)");
clear choice;

%% Functions

function inp = showMenu(movies)
    fprintf("1 - Your Movies\n2 - Get Suggestions\n3 - Search Title\n4 - Exit\n");
    inp = input("Select choice: " );
    while floor(inp) ~= inp || inp < 1 || inp > 4
        inp = input("Choice must be a integer! (1 to 4): ");
    end
    
    switch inp
        case 3
            name = input("Write a string: ", 's');
            C1 = unique(strsplit(lower(name)));
            semelhantes = cell(1,5); % 5 filmes, no máximo
            minimos = ones(1,5); % as 5 menores distancias de J
            for i=1:size(movies,1)
                filme = movies{1,1};
                C2 = unique(strsplit(lower(filme)));
                distJ = 1 - (length(intersect(C1,C2))/length(union(C1,C2)))
            end
            
            
    end
    
end