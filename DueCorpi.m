% Script per la visualizzazione dell'orbita in coordinate cartesiane del
% moto di due corpi con origine degli assi nel centro di massa
% al variare di eccentricità e semi asse maggiore e delle due masse


% Inizializzazione
clear       % clear variables
clc         % clear command window

e = 0.4;                   % eccentricità
a = 1;                     % semiasse maggiore
N = 30;                    % numero di punti per l'orbita discreta
lo = linspace(0,2*pi,N);   % anomalia media per parametrizzare il tempo
u = zeros(1,N);            % preallocate space for eccentric anomaly array
m1=1;                      % prima massa (lascia fissa)
m2=2;                      % seconda massa (max 20 per visualizzazione)
giri=10;                   % numero di giri per animazione
x=zeros(N);                
y=zeros(N);
x1=zeros(N);
y1=zeros(N);
x2=zeros(N);
y2=zeros(N);


% Calcolo anomalia eccentrica utilizzando il metodo di newton
for j = 1:N
    u(j)=fzero(@(u)u-e*sin(u)-lo(j), 0);
end


% Calcolo coordinate polari (theta, r) dall'anomalia eccentrica
theta = 2 * atan(sqrt((1+e)/(1-e)) * tan(u/2));
r = a * (1-e^2) ./ (1 + e*cos(theta));


% Cordinate cartesiane dei due punti nel riferimento del centro di massa
for i=1:N
x(i)=r(i)*cos(theta(i));
y(i)=r(i)*sin(theta(i));

x1(i)=(m2 *x(i))/(m1+m2);
y1(i)=(m2 *y(i))/(m1+m2);

x2(i)=-(m1 *x(i))/(m1+m2);
y2(i)=-(m1 *y(i))/(m1+m2);
end



% Per centrare il plot dell'orbita
Mx1=max(x1);
mx1=min(x1);
My1=max(y1);
my1=min(y1);
Mx2=max(x2);
mx2=min(x2);
My2=max(y2);
my2=min(y2);


%Plot animazione
for i=0:giri*N-1
    % punti fake per centrare l'orbita
    fake=plot(Mx1,My1,'o','Color','k');
    hold on
    fake2=plot(mx1,my1,'h','Color','k');
    set(gca,'Color','k')
    fake3=plot(Mx2,My2,'o','Color','k');
    fake4=plot(mx2,my2,'h','Color','k');
    hold on
    % plot centro di masssa e due punti
    title(' Problema dei due corpi nel riferimento del centro di massa ');
    plot(0,0,'*','Color','b')
    hold on
    plot(x1(mod(i,N)+1),y1(mod(i,N)+1),'o','Color','w','MarkerSize',10,'MarkerFaceColor','w');
    hold on
    plot(x2(mod(i,N)+1),y2(mod(i,N)+1),'o','Color','r','MarkerSize',10+5*m2-5,'MarkerFaceColor','r');
    hold on
    % plot scia
    for j=i-10 :i-1
        h=j;
        plot(x1(mod(h,N)+1),y1(mod(h,N)+1),'.','Color','w','MarkerFaceColor','w');
        hold on
        plot(x2(mod(h,N)+1),y2(mod(h,N)+1),'.','Color','r','MarkerFaceColor','r');
        hold on
    end
    % pausa animazione
    pause(0.05);
    % per chiudere il ciclo in caso di chiusura finestra plot
    if ishandle(fake) == false
        break;
    end
    hold off;
end






