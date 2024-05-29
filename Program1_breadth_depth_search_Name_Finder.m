function name_search()
    % Load dictionaries from files
    boy_names = load_names('boy_names.txt');
    girl_names = load_names('girl_names.txt');

    % Take input
    num_letters = input('Enter number of letters: ');
    search_type = input('Enter search type (breadth/depth): ', 's');
    gender = input('Enter gender (boy/girl): ', 's');

    % Select the appropriate dictionary based on gender
    if strcmp(gender, 'boy')
        names = boy_names;
    elseif strcmp(gender, 'girl')
        names = girl_names;
    else
        error('Invalid gender input. Enter "boy" or "girl".');
    end

    % Perform search
    if strcmp(search_type, 'breadth')
        result = breadth_first_search(names, num_letters);
    elseif strcmp(search_type, 'depth')
        result = depth_first_search(names, num_letters);
    else
        error('Invalid search type input. Enter "breadth" or "depth".');
    end

    % Display the result
    if isempty(result)
        disp('No matching name found.');
    else
        fprintf('Matching name found: %s\n', result);
    end
end

function names = load_names(filename)
    % Load names from a text file
    fid = fopen(filename, 'r');
    if fid == -1
        error('Cannot open file: %s', filename);
    end
    names = textscan(fid, '%s');
    names = names{1};
    fclose(fid);
end

function result = breadth_first_search(names, num_letters)
    % Implementing BFS to search for a name
    queue = names;
    while ~isempty(queue)
        current_name = queue{1};
        queue(1) = [];
        if length(current_name) == num_letters
            result = current_name;
            return;
        end
    end
    result = [];
end

function result = depth_first_search(names, num_letters)
    % Implementing DFS to search for a name
    stack = names;
    while ~isempty(stack)
        current_name = stack{1};
        stack(1) = [];
        if length(current_name) == num_letters
            result = current_name;
            return;
        end
    end
    result = [];
end