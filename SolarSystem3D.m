% Script per animazione 3D delle movimento dei primi 4 pianeti del
% sistema solare al passare dei giorni


clear           % clear variables
clc             % clear command window

%mercurio, venere, terra, marte, LUNA

e = [0.205 0.007 0.017 0.094];     % eccentricità
a = [46 107.5 147.1 206.6];        % semi-major axis *Km*10^5
T = [88 224.7 365.2 687];          % priodo in giorni
Diam = [ 4879 12104 12756 6792 ];  % diametro in km
distLuna= 10;                      % 3.8 *10^5 km
Days=5000;                         % numero di giorni durata animazione
N = 50;                    % numero di punti per l'orbita discreta
lo = linspace(0,2*pi,N);   % anomalia media per parametrizzare il tempo
u = zeros(1,N);            % anomalia eccentrica
incl=[7 3.39 0 1.85];      % inclinazione orbita in gradi risp. eclittica
in= (incl.*pi)./180;       % e in radianti

% Calcolo orbite pianeti sul piano
for i=1:4
    % calcolo anomalia eccentrica utilizzando il metodo di newton
    for j = 1:N
        u(j)=fzero(@(u)u-e(i)*sin(u)-lo(j), 0);
    end
    % calcolo coordinate dall'anomalia eccentrica
    theta = 2 * atan(sqrt((1+e(i))/(1-e(i))) * tan(u/2));
    r = a(i) * (1-e(i)^2) ./ (1 + e(i)*cos(theta));
    X(:,i)=r.*cos(theta);
    Y(:,i)=r.*sin(theta);
end


% Calcolo orbita pianeti inclinata
for i=1:4
    for j=1:N
        X(j,i)=cos(in(i))* X(j,i);
        Z(j,i)=-sin(in(i))*X(j,i);
    end
end



% Plot animazione
for t=0:5: Days 

    % plot orbita pianeti
plot3(X,Y,Z);
hold on
h=plot3(0,0,0,'o','Color','r','MarkerFaceColor','r', 'MarkerSize',20);
if  ishghandle(h) == false
        break;
end
hold on
 set(gca,'Color','k')
       title(['Giorno = ' sprintf('%d',t)])
   % plot pianeti
    for i=1:4
        al=fzero(@(u)u-e(i)*sin(u)- 2*pi/T(i)*t, 0);
        angolo = 2 * atan(sqrt((1+e(i))/(1-e(i))) * tan(al/2));
        raggio = a(i) * (1-e(i)^2) ./ (1 + e(i)*cos(angolo));
        if angolo>0
            phi=(-2*in(i)*angolo/pi)+in(i);
        else
            phi= ((2*in(i))*(angolo+pi)/pi)- in(i);
        end
        Xt=raggio*cos(angolo);
        Yt=raggio*sin(angolo); 
        Xt= cos(in(i))* Xt;
        Zt=-sin(in(i))* Xt;
        plot3(Xt,Yt,Zt,'o','Color','r','MarkerFaceColor','r','MarkerSize',Diam(i)/2000);
        hold on;
        %plot luna
        if i==3
            plot3(Xt+ distLuna*cos(2*pi*t/28), Yt + distLuna*sin(2*pi*t/28), Zt ,'o','Color','w','MarkerFaceColor','w','MarkerSize',2);
            hold on;
        end
    end
    
    % punti fake per centrare l'animazione
    axis([-250 250 -250 250 -60 60])
    % pausa animazione
    pause(0.005);
    % per chiudere il ciclo in caso di chiusura finestra plot
    hold off
end






