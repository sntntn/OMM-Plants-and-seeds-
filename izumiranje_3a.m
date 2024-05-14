
format long

gama = 2;     % broj semena koje proizvede biljka
delta = 0.8;  % procenat semenja koji prezivi zimu od proizvedenih

% naredna dva parametra cemo da stelujemo
alpha = 0.5;    % procenat proklijalih semenja u 1. sezoni od prezivelih(gama*delta)
beta = 0.2;     % procenat dvogodisnjeg semenja koje je proklijalo u 2. sezoni 

izumrla_vrsta = false; % bool vrednost koja ce nam pokazati da li je vrsta izumrla

n_preth = 0;
n = 100;
n_pocetno=n;

while ~izumrla_vrsta && alpha >= 0 
    for i = 1:20
        n = n * (alpha * gama * delta) + n_preth * (beta * (gama * delta - alpha * gama * delta) );

        if i==1
            prirastaj=n-n_pocetno
            %koef = n / n_pocetno;
        else
            prirastaj = n - n_preth;
            %koef = n / n_preth;

        end        
        n_preth = n;
        disp(['Iteracija broj ', num2str(i), ' n=', num2str(n), ' prirastaj=', num2str(prirastaj)]);
        %disp(['koeficijent uvecanja/umanjenja ', num2str(koef)]);
        %disp([' '])
        
        if n <= 0.5
            izumrla_vrsta = true; 
            break; % Izlazak iz unutrasnje petlje ako je vrsta izumrla
        end
    
    end

    if izumrla_vrsta
        disp('Vrsta je izumrla sa alpha = ');
        disp(alpha);
        disp('i beta = ');
        disp(beta);
        break; % Izlazak iz spoljne petlje ako je vrsta izumrla
    end

    % Smanjivanje alpha i resetovanje n i n_preth za sledeću iteraciju
    alpha = alpha - 0.05;
    n = 100;
    n_preth = 0;
    disp([' ']);
end

if ~izumrla_vrsta
    disp('Vrsta nije izumrla za trenutno podešene vrednosti parametara.');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% prikaz trazene generacije

if izumrla_vrsta
    n_preth = 0;
    n = 100;
    % Kreiranje tabele sa podacima o populaciji
    data = zeros(21, 2);
    data(1,:) = [1,n];
    for i = 2:21
        n = n * (alpha * gama * delta) + n_preth * (beta * (gama * delta - alpha * gama * delta) );

        n_preth = n;

        % Dodavanje podataka u matricu
        data(i, :) = [i, n];
        
    end


    % Plotovanje grafikona populacije
    figure;
    plot(data(:, 1)-1, data(:, 2), '-o');
    title('Dinamika populacije izumrle generacije');
    xlabel('Iteracija');
    ylabel('Populacija');
end



