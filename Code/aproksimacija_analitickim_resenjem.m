format long
%n(t+1) = n(t)(alpha*gama*sigma) + n(t-1)(beta*sigma*sigma*gama * (1 - alpha))

gama = 2;     % broj semena koje proizvede biljka
sigma = 0.8;  % procenat semenja koji prezivi zimu od proizvedenih
alpha = 0.5;  % procenat proklijalih semenja u 1. sezoni od prezivelih(gama*sigma)
beta = 0.4;   % procenat dvogodisnjeg semenja koje je proklijalo u 2. sezoni 

n_preth = 0;
n = 20;

disp(['Posadjeno ',num2str(n),' semenja']);
disp(['generacija broj 1 n=',num2str(n_preth)]);
for i = 2:10
    n = n * (alpha * gama * sigma) + n_preth * (beta*sigma*sigma*gama * (1 - alpha));

    n_preth=n;
    disp(['Generacija broj ', num2str(i), ' n=',num2str(n)]);
end
disp('petlja se zavrsila');



n0=0;
n1=20;

koren=sqrt(gama*gama*alpha*alpha + 4*beta*gama*(1-alpha));
c1=(n1-n0*(sigma*(gama*alpha - koren)/2 ) )/(sigma*koren);
c2=(n0*(sigma*(gama*alpha + koren)/2 ) - n1)/(sigma*koren);

t=10;          %ovde zadajemo koju hocemo generaciju
nt = c1*(sigma*(gama*alpha + koren)/2 ).^t + c2*(sigma*(gama*alpha - koren)/2 ).^t;
disp(['Analiticko resenje za broj biljaka u generaciji ', num2str(t), ', n=',num2str(nt)]);






