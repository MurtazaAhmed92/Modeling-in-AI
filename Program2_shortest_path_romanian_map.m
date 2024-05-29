function find_all_paths_romanian_map()
    % Define the graph
    graph = containers.Map;
    graph('Arad') = {'Zerind', 75, 'Sibiu', 140, 'Timisoara', 118};
    graph('Zerind') = {'Arad', 75, 'Oradea', 71};
    graph('Oradea') = {'Zerind', 71, 'Sibiu', 151};
    graph('Sibiu') = {'Arad', 140, 'Oradea', 151, 'Fagaras', 99, 'Rimnicu Vilcea', 80};
    graph('Timisoara') = {'Arad', 118, 'Lugoj', 111};
    graph('Lugoj') = {'Timisoara', 111, 'Mehadia', 70};
    graph('Mehadia') = {'Lugoj', 70, 'Drobeta', 75};
    graph('Drobeta') = {'Mehadia', 75, 'Craiova', 120};
    graph('Craiova') = {'Drobeta', 120, 'Rimnicu Vilcea', 146, 'Pitesti', 138};
    graph('Rimnicu Vilcea') = {'Sibiu', 80, 'Craiova', 146, 'Pitesti', 97};
    graph('Fagaras') = {'Sibiu', 99, 'Bucharest', 211};
    graph('Pitesti') = {'Rimnicu Vilcea', 97, 'Craiova', 138, 'Bucharest', 101};
    graph('Bucharest') = {'Fagaras', 211, 'Pitesti', 101, 'Giurgiu', 90, 'Urziceni', 85};
    graph('Giurgiu') = {'Bucharest', 90};
    graph('Urziceni') = {'Bucharest', 85, 'Hirsova', 98, 'Vaslui', 142};
    graph('Hirsova') = {'Urziceni', 98, 'Eforie', 86};
    graph('Eforie') = {'Hirsova', 86};
    graph('Vaslui') = {'Urziceni', 142, 'Iasi', 92};
    graph('Iasi') = {'Vaslui', 92, 'Neamt', 87};
    graph('Neamt') = {'Iasi', 87};

    % Take input
    start_city = input('Enter the start city: ', 's');
    end_city = input('Enter the end city: ', 's');

    % Find all paths
    all_paths = find_all_paths(graph, start_city, end_city);

    % Calculate path costs and find the shortest path
    [shortest_path, shortest_cost, path_costs] = calculate_paths_cost(all_paths);

    % Display the results
    disp('All possible routes with their path costs:');
    for i = 1:length(all_paths)
        fprintf('Path %d: %s, Cost: %d\n', i, strjoin(all_paths{i}, ' -> '), path_costs(i));
    end

    fprintf('\nShortest path: %s, Cost: %d\n', strjoin(shortest_path, ' -> '), shortest_cost);
end

function paths = find_all_paths(graph, start, goal)
    % Recursive function to find all paths
    paths = {};
    stack = {{start, {start}}};
    while ~isempty(stack)
        [current, path] = stack{end}{:};
        stack(end) = [];
        if strcmp(current, goal)
            paths{end+1} = path; %#ok<AGROW>
        else
            neighbors = graph(current);
            for i = 1:2:length(neighbors)
                neighbor = neighbors{i};
                if ~ismember(neighbor, path)
                    stack{end+1} = {neighbor, [path, neighbor]}; %#ok<AGROW>
                end
            end
        end
    end
end

function [shortest_path, shortest_cost, path_costs] = calculate_paths_cost(paths)
    % Define the graph with distances
    distances = containers.Map;
    distances('Arad-Zerind') = 75; distances('Zerind-Arad') = 75;
    distances('Arad-Sibiu') = 140; distances('Sibiu-Arad') = 140;
    distances('Arad-Timisoara') = 118; distances('Timisoara-Arad') = 118;
    distances('Zerind-Oradea') = 71; distances('Oradea-Zerind') = 71;
    distances('Oradea-Sibiu') = 151; distances('Sibiu-Oradea') = 151;
    distances('Sibiu-Fagaras') = 99; distances('Fagaras-Sibiu') = 99;
    distances('Sibiu-Rimnicu Vilcea') = 80; distances('Rimnicu Vilcea-Sibiu') = 80;
    distances('Timisoara-Lugoj') = 111; distances('Lugoj-Timisoara') = 111;
    distances('Lugoj-Mehadia') = 70; distances('Mehadia-Lugoj') = 70;
    distances('Mehadia-Drobeta') = 75; distances('Drobeta-Mehadia') = 75;
    distances('Drobeta-Craiova') = 120; distances('Craiova-Drobeta') = 120;
    distances('Craiova-Rimnicu Vilcea') = 146; distances('Rimnicu Vilcea-Craiova') = 146;
    distances('Craiova-Pitesti') = 138; distances('Pitesti-Craiova') = 138;
    distances('Rimnicu Vilcea-Pitesti') = 97; distances('Pitesti-Rimnicu Vilcea') = 97;
    distances('Fagaras-Bucharest') = 211; distances('Bucharest-Fagaras') = 211;
    distances('Pitesti-Bucharest') = 101; distances('Bucharest-Pitesti') = 101;
    distances('Bucharest-Giurgiu') = 90; distances('Giurgiu-Bucharest') = 90;
    distances('Bucharest-Urziceni') = 85; distances('Urziceni-Bucharest') = 85;
    distances('Urziceni-Hirsova') = 98; distances('Hirsova-Urziceni') = 98;
    distances('Hirsova-Eforie') = 86; distances('Eforie-Hirsova') = 86;
    distances('Urziceni-Vaslui') = 142; distances('Vaslui-Urziceni') = 142;
    distances('Vaslui-Iasi') = 92; distances('Iasi-Vaslui') = 92;
    distances('Iasi-Neamt') = 87; distances('Neamt-Iasi') = 87;

    % Calculate the cost for each path
    path_costs = zeros(1, length(paths));
    for i = 1:length(paths)
        path = paths{i};
        cost = 0;
        for j = 1:length(path) - 1
            cost = cost + distances([path{j} '-' path{j+1}]);
        end
        path_costs(i) = cost;
    end

    % Find the shortest path
    [shortest_cost, idx] = min(path_costs);
    shortest_path = paths{idx};
end
