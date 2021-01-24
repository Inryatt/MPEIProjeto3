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

