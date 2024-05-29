% Main function to run the Tic-Tac-Toe game
function tic_tac_toe_game
    board = [' ' ' ' ' '; ' ' ' ' ' '; ' ' ' ' ' '];
    clc;
    disp('Tic-Tac-Toe Game');
    disp('1. Computer vs Computer');
    disp('2. Human vs Computer');
    choice = input('Choose mode (1 or 2): ');
    
    if choice == 1
        computer_vs_computer(board);
    elseif choice == 2
        human_vs_computer(board);
    else
        disp('Invalid choice.');
    end
end

% Function for computer vs. computer mode
function computer_vs_computer(board)
    while true
        clc;
        disp('Computer vs Computer');
        display_board(board);
        [~, move] = minimax(board, true);
        if isempty(move)
            break;
        end
        board(move(1), move(2)) = 'X';
        clc;
        display_board(board);
        if check_winner(board)
            break;
        end
        pause(1);
        [~, move] = minimax(board, false);
        if isempty(move)
            break;
        end
        board(move(1), move(2)) = 'O';
        clc;
        display_board(board);
        if check_winner(board)
            break;
        end
        pause(1);
    end
end

% Function for human vs. computer mode
function human_vs_computer(board)
    while true
        clc;
        disp('Human vs Computer');
        display_board(board);
        if check_winner(board)
            break;
        end
        if all(board(:) ~= ' ')
            disp('It''s a tie!');
            break;
        end
        
        % Human move
        [row, col] = get_human_move(board);
        board(row, col) = 'O';
        clc;
        display_board(board);
        if check_winner(board)
            break;
        end
        
        % Computer move
        [~, move] = minimax(board, true);
        if isempty(move)
            break;
        end
        board(move(1), move(2)) = 'X';
        clc;
        display_board(board);
        if check_winner(board)
            break;
        end
    end
end

% Function to display the board
function display_board(board)
    disp('Current Board:');
    for i = 1:3
        fprintf(' %c | %c | %c \n', board(i, 1), board(i, 2), board(i, 3));
        if i < 3
            disp('---|---|---');
        end
    end
    disp(' ');
end

% Minimax function
function [score, move] = minimax(board, isMaximizing)
    scores = containers.Map({'X', 'O', 'tie'}, {1, -1, 0});
    winner = check_winner(board);
    if ~isempty(winner)
        score = scores(winner);
        move = [];
        return;
    end
    if isMaximizing
        best_score = -Inf;
        move = [];
        for i = 1:3
            for j = 1:3
                if board(i, j) == ' '
                    board(i, j) = 'X';
                    [new_score, ~] = minimax(board, false);
                    board(i, j) = ' ';
                    if new_score > best_score
                        best_score = new_score;
                        move = [i, j];
                    end
                end
            end
        end
    else
        best_score = Inf;
        move = [];
        for i = 1:3
            for j = 1:3
                if board(i, j) == ' '
                    board(i, j) = 'O';
                    [new_score, ~] = minimax(board, true);
                    board(i, j) = ' ';
                    if new_score < best_score
                        best_score = new_score;
                        move = [i, j];
                    end
                end
            end
        end
    end
    score = best_score;
end

% Check winner function
function winner = check_winner(board)
    lines = [board(1, :); board(2, :); board(3, :); board(:, 1)'; board(:, 2)'; board(:, 3)'; [board(1, 1), board(2, 2), board(3, 3)]; [board(1, 3), board(2, 2), board(3, 1)]];
    if any(all(lines == 'X', 2))
        winner = 'X';
        disp('Computer (X) wins!');
    elseif any(all(lines == 'O', 2))
        winner = 'O';
        disp('Human (O) wins!');
    elseif all(board(:) ~= ' ')
        winner = 'tie';
        disp('It''s a tie!');
    else
        winner = '';
    end
end

% Function to get human move
function [row, col] = get_human_move(board)
    while true
        move = input('Enter your move (row and column) as [row col]: ');
        if length(move) == 2 && board(move(1), move(2)) == ' '
            row = move(1);
            col = move(2);
            break;
        else
            disp('Invalid move. Try again.');
        end
    end
end
