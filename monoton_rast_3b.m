
format long

gama = 2;     % broj semena koje proizvede biljka
delta = 0.8;  % procenat semenja koji prezivi zimu od proizvedenih

% naredna dva parametra cemo da stelujemo
alpha = 0.5;    % procenat proklijalih semenja u 1. sezoni od prezivelih(gama*delta)
beta = 0.4;     % procenat dvogodisnjeg semenja koje je proklijalo u 2. sezoni 

monoton_rast = false; % bool vrednost koja ce nam pokazati da li je vrsta ostvarila monoton rast

n_preth = 0;
n = 100;
n_pocetno=n;

while ~monoton_rast && alpha <= 1
    ima_pad = false;
    for i = 1:20
        n = n * (alpha * gama * delta) + n_preth * (beta*delta * (gama * delta - alpha * gama * delta) );

        if i==1
            prirastaj=n-n_pocetno
        else
            prirastaj = n - n_preth;
        end
        n_preth = n;
        disp(['Iteracija broj ', num2str(i), ' n=', num2str(n), ' prirastaj=', num2str(prirastaj)]);
        %disp([' '])
        
        %if prirastaj>0      moze da zameni sledeci if
        if n < n_preth || n < n_pocetno  %zbog prve iteracije petlje
            ima_pad = true;
            break; % Izlazak iz unutrasnje petlje ako vrsta ima pad
        end
    
    end

    if ima_pad==false
        monoton_rast=true;
    end

    if monoton_rast
        disp('Vrsta je ostvarila monoton rast sa alpha = ');
        disp(alpha);
        disp('i beta = ');
        disp(beta);
        break; % Izlazak iz spoljne petlje ako je vrsta ostvarila monoton rast
    end

    % Smanjivanje alpha i resetovanje n i n_preth za sledeu iteraciju
    alpha = alpha + 0.05;
    n = 100;
    n_preth = 0;
    disp([' ']);
end

if ~monoton_rast
    disp('Vrsta nije ostvarila monoton rast za trenutno podeene vrednosti parametara.');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% prikaz trazene generacije

if monoton_rast
    n_preth = 0;
    n = 100;
    % Kreiranje tabele sa podacima o populaciji
    data = zeros(21, 2);
    data(1,:) = [1,n];
    for i = 2:21
        n = n * (alpha * gama * delta) + n_preth * (beta*delta * (gama * delta - alpha * gama * delta) );

        n_preth = n;

        % Dodavanje podataka u matricu
        data(i, :) = [i, n];
        
    end


    % Plotovanje grafikona populacije
    figure;
    plot(data(:, 1)-1, data(:, 2), '-o');
    title('Dinamika populacije generacije koja je ostvarila monoton rast');
    xlabel('Iteracija');
    ylabel('Populacija');
end

