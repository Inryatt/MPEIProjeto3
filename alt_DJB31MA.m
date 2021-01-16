function h= alt_DJB31MA(chave, seed, k)
% implementação da hash function DJB31MA com base no algoritmo obtido
% no resumo 2014(PJF) que está em C
%
%  chave    array de caracteres com a chave
%  seed     semente que permite obter vários hash codes para a mesma chave
%   k       número de hashfunctions
%
%   h        hashcode devolvido
len= length(chave);
chave= double(chave);
val= seed;
for i=1:len
    val = mod(31 * val + chave(i), 2^32 -1) ;
end

h = zeros(k,1);

for i=1:5 % evitar de o primeiro valor ser um valor pequeno (5 parece o ideal)
    val = mod(31 * val(1) + num2str(i), 2^32 -1);
end

for i=1:k % adicionar cada hashfunction na matrix
    val = mod(31 * val(1) + num2str(i), 2^32 -1);
    h(i) = val(1);
end
