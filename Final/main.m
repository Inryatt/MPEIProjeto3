
if ~exist('initi','var')
    initi=initialize();
     load('initialization.mat');
else
    load('initialization.mat');
end

if initi==0
    disp("ERRO: Programa não inicializado!");
end

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
            
            print_by_genre(unwatched_movies,genre); % prints the movies of the desired genre
            
            
            
        case 3
            dist2 = search(shinglesMinHash, ns, k, n_movies);
            [distancia,pos] = mink(dist2,5);
            for i=1:5
                if distancia(i) <= 0.99 % print se <= 0.99
                    m = moviesData(pos(i));
                    fprintf("%-50s \t\t %-5f\n",m{1},distancia(i));
                else
                    break
                end
            end
            if i == 1 % se não houve nenhum print
                fprintf("No movie with that conditions...\n")
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
    genres=["", "unknown","Action","Adventure","Animation","Children's",...
    "Comedy", "Crime","Documentary","Drama","Fantasy","Film-Noir",...
    "Horror","Musical","Mystery","Romance","Sci-Fi","Thriller","War","Western"];

    fprintf("1- Action   2- Adventure  3- Animation   4- Children’s\n5- Comedy   6- Crime      7- Documentary 8- Drama\n9- Fantasy  10- Film-Noir 11- Horror     12- Musical\n13- Mystery 14- Romance   15- Sci-Fi     16- Thriller\n17- War     18- Western\n\n");
    genre = input("Select genre: " );
        
    while floor(genre) ~= genre || genre < 1 || genre > 18
        genre = input("Choice must be a integer! (1 to 18): ");
    end
    genre=genre+2;
    fprintf("Selected genre: %s\n",genres(genre));
    newline;

end

function movieids = get_movies(userid,udata)
    tmp = udata(:,1)== userid;  % tmp = linhas em que o userid é o dado
    uinfo=udata(tmp,:);         % uinfo = matriz com os userids = userid e os movies desse userid
    movieids = unique(uinfo(:,2));
end

function show_movies(userid,udata,movies,genres)
    tmp=udata(:,1)== userid; % aqui obtemos um array binário: 1 se a primeira coluna 
                            % tiver valor igual ao userid que pretendemos
    uinfo=udata(tmp,:); % tira-se as linhas em que temos 1s no array acima
    movieid=uinfo(:,2); % obtém-se os ids dos filmes vistos pelo utilizador
    for i=1:length(movieid)
        toPrint="";
        tmpgen=[];
        name=movies{i,1};
        for k=2:length(genres)
           if movies{i,k}
               tmpgen=[tmpgen genres(k)]  ; %por cada filme é gerado um array
                                            % temporário com os géneros
                                            % desse filme
           end
        end
        toPrint=append(toPrint,sprintf("%-70s",name)); % junta-se o nome á linha a imprimir
                                                       % no terminal
        for a=1:length(tmpgen)
           toPrint=append(toPrint,sprintf("| %-15s",tmpgen(a)));
           %acrescenta-se os géneros do filme associado, na mesma linha
        end
        disp(toPrint);
        newline;
        
    end
    
end

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

function print_by_genre(movies,genre)  
    matches=0; %inicialização do contador
    siz = size(movies);
    siz=siz(1);
    for i=1:siz
      
        if movies{i,(genre)}==1 % se o filme pertencer ao género escolhido
            fprintf("%s\n",movies{i,1}); % é impresso
            matches=matches+1; % e aumenta-se o número de filmes encontrados
        end
    end
            
    if matches==0 % se o utilizador mais parecido não tiver visto nenhum filme do género pretendido
               % é impressa a seguinte mensagem: 
    disp("Não temos nenhuma sugestão para o género escolhido! :( "); 
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
    % evitar de o primeiro valor ser um valor pequeno (5 parece o ideal)
        val = mod(31 * val(1) + num2str(i), 2^32 -1);
    end

    for i=1:k % adicionar cada hashfunction na matrix
        val = mod(31 * val(1) + num2str(i), 2^32 -1);
        h(i) = val(1);
    end
end

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
    
%% Maneira de se fazer não utilizando minHashs
%    C1 = unique(strsplit(lower(name)));
%    distancias = zeros(1, size(movies,1));
%    for i=1:size(movies,1)
%      filme = movies{i,1};
%      C2 = unique(strsplit(lower(filme)));
%      distancias(i) = 1 - (length(intersect(C1,C2))/length(union(C1,C2)));
%      % distancia de Jaccard
%    end
%    [mi,index] = mink(distancias,5); 
%    % as 5 menores distancias e seus indices
%    for i = 1:5
%      if mi(i) > 0.99 % não mostrar se a distancia for > 0.99
%          if i == 1
%              disp("We don't have nothing like that :(");
%          end
%          break
%      end
%      fprintf(distancias(index(i)) + " | " + movies{index(i),1} + "\n");
%     end
end

