% Script per visualizzare l'orbita in coordinate polari del problema
% dei due corpi ridotto, al variare di eccentricità e semiasse maggiore

% Inizializzazione
clear       % clear variables
clc         % clear command window

e = 0.4;                   % eccentricità
a = 1;                     % semiasse maggiore
N = 30;                    % numero di punti per l'orbita discreta
lo = linspace(0,2*pi,N);   % anomalia media per parametrizzare il tempo
u = zeros(1,N);            % preallocate space for eccentric anomaly array
giri=2;                    % numero di giri per animazione

% Calcolo anomalia eccentrica utilizzando il metodo di newton
for j = 1:N
    u(j)=fzero(@(u)u-e*sin(u)-lo(j), 0);
end


% Calcolo coordinate polari (theta, r) dall'anomalia eccentrica
theta = 2 * atan(sqrt((1+e)/(1-e)) * tan(u/2));
r = a * (1-e^2) ./ (1 + e*cos(theta));


% Plot in coordinate polari dell'orbita
for j=1:giri;
    for i=1:N
        % punto fake per centrare l'orbita
        h_fake = polar(0,2*a);
        set(h_fake, 'Color', 'w');
        hold on;
        % plot del sole e dell'orbita
        title(['Elliptical Orbit with e = ' sprintf('%.2f',e)]);
        v=[1 rand(1,1) 0]; %un colore RGB caldo per il sole
        S=polar(0,0,'o');
        set(S,'Color',v,'MarkerFaceColor',v ,'MarkerSize',20);
        hold on;
        L=polar(theta(i),r(i),'o');
        set(L,'Color','b','MarkerSize',10);
        % pausa animazione
        pause(0.05);
        % per chiudere il ciclo in caso di chiusura finestra plot
        if ishandle(L) == false
            break;
        end
    end
     % per chiudere il ciclo in caso di chiusura finestra plot
    if ishandle(L) == false
        break;
    end
    hold off;
end


