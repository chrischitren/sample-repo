H = -([ones(4,4) zeros(4,4) ; zeros(4,4) ones(4,4)]+eye(8))+2*eye(8);
H(4,5) = -1;
H(5,4) = -1;

H

[eH, eh] = eig(H)

% Initialize some positions for the vertices of the graph (this is only a
% visual concern, these positions are irrelevant to the problem)
vertPos = [-2.0 -1.5 -1.5 -0.7  0.7  1.5  1.5  2.0;
            0.0  0.7 -0.7  0.0  0.0  0.7 -0.7  0.0];

% Set up a color map for coloring vertices according to corresponding
% eigenvector component
map1 = [ [zeros(50,1) linspace(1,1/50,50).'  linspace(1,1/50,50).'] ; [0 0 0]; [linspace(1/50,1,50).' zeros(50,1) linspace(1/50,1,50).'] ];
maxComp = max(eH,[],"all");
minComp = min(eH,[],"all");

% Set up the ordering so that nicely symmetrical eigenvectors are displayed
% next to each other
ordering = [1,2,5,7,3,8,4,6];

% For each eigenvector, display its graph:
for eigVecIndex = 1:8

    % Set up plot for displaying graph
    subplot(2,4,eigVecIndex), hold on, axis image, xlim([-2.5,2.5]), ylim([-1.2,1.2]), axis off
    
    % Plot edges of the graph by checking the adjacency matrix
    for u = 1:size(H,1)
        for v = u:size(H,2)
            if(H(u,v) == -1)
                subplot(2,4,eigVecIndex), plot([vertPos(1,u) vertPos(1,v)], [vertPos(2,u),vertPos(2,v)], "k-")
            end
        end
    end

    % Plot vertices of the graph
    for k = 1:size(vertPos,2)
        colorIndex = floor(100*(eH(k,ordering(eigVecIndex))-minComp)/(maxComp-minComp))+1;
        subplot(2,4,eigVecIndex), scatter(vertPos(1,k),vertPos(2,k), 300, map1(colorIndex,:), "filled")
    end

end