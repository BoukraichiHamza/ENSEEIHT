function out = modulo(in,mod)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% ROLE: calcule le reste de in modulo mod
%
% AUTEUR:   Fr�d�ric MONNAIE
%           1/1/99
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nb=floor(abs(in/mod));
out=in-nb.*mod;
