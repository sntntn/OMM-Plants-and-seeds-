
format long

gama = 2;     % broj semena koje proizvede biljka
sigma = 0.8;  % procenat semenja koji prezivi zimu od proizvedenih

%parametar koji sami zadajemo
alpha = 0.5;    % procenat proklijalih semenja u 1. sezoni od prezivelih(gama*sigma) 

%svaka manja vrednost parametra beta ispod BetaMax dovodi do izumiranja vrste
BetaMax = (4-6.4*alpha)/(5.12*(1-alpha));
beta=BetaMax-0.01;     % procenat dvogodisnjeg semenja koje je proklijalo u 2. sezoni

if beta<0
    disp('Za zadat parametar alpha, vrsta ne moze da izumre')
else
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% prikaz trazene generacije
    n_preth = 0;
    n = 100;
    % Kreiranje tabele sa podacima o populaciji
    data = zeros(21, 2);
    data(1,:) = [1,n];
    for i = 2:21
        n = n * (alpha * gama * sigma) + n_preth * (beta*sigma*sigma*gama * (1 - alpha));
    
        n_preth = n;
    
        % Dodavanje podataka u matricu
        data(i, :) = [i, n]; 
    end 
    % Plotovanje grafikona populacije
    figure;
    plot(data(:, 1)-1, data(:, 2), '-o');
    title(['Dinamika populacije izumrle generacije za, alpha=', num2str(alpha),', beta=',num2str(beta)]);
    xlabel('Iteracija');
    ylabel('Populacija');
end





