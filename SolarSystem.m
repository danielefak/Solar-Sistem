% Script per animazione 2D delle movimento dei primi 4 pianeti del
% sistema solare al passare dei giorni

% Inizializzazione
clear           % clear variables
clc             % clear command window

e = [0.205 0.007 0.017 0.094];     % eccentricità
a = [46 107.5 147.1 206.6];        % semi-major axis *Km*10^5
T = [88 224.7 365.2 687];          % priodo in giorni
Diam = [ 4879 12104 12756 6792 ];  % diametro in km
distLuna= 7;                       % 3.8 *10^5 km
N = 50;                    % numero di punti per l'orbita discreta
lo = linspace(0,2*pi,N);   % anomalia media per parametrizzare il tempo
u = zeros(1,N);            % anomalia eccentrica


% Calcolo orbite pianeti
for i=1:4;
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


% Plot dei pianeti
for t=0:5:70000
    title(['Giorno = ' sprintf('%d',t)])
    % Plot orbite pianeti
    plot(X,Y);
    hold on
    % plot sole
    plot(0,0,'o','Color','r','MarkerFaceColor','r', 'MarkerSize',20);
    set(gca,'Color','k');
    hold on;
    % plot pianeti
    for i=1:4
        al=fzero(@(u)u-e(i)*sin(u)- 2*pi/T(i)*t, 0);
        angolo = 2 * atan(sqrt((1+e(i))/(1-e(i))) * tan(al/2));
        raggio = a(i) * (1-e(i)^2) ./ (1 + e(i)*cos(angolo));
        Xt=raggio*cos(angolo);
        Yt=raggio*sin(angolo);
        h=plot(Xt,Yt,'o','Color','r','MarkerFaceColor','r','MarkerSize',Diam(i)/2000);
        hold on;
        % plot luna
        if i==3
            plot(Xt+ distLuna*cos(2*pi*t/28), Yt + distLuna*sin(2*pi*t/28),'o','Color','w','MarkerFaceColor','w','MarkerSize',2);
        end
    end
    % pausa animazione
    pause(0.005);
     % per chiudere il ciclo in caso di chiusura finestra plot
    if ishandle(h) == false
        break;
    end
    hold off
end






