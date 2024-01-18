function [Rotated] = Rotate(Input, Theta)
% Rotate Input image by theta DEGREES.

%% Transformation Matrix
mat = [
    cos(deg2rad(Theta)) sin(deg2rad(Theta));
    -sin(deg2rad(Theta)) cos(deg2rad(Theta))
    ]; % Forward

inverse = inv(mat); % Reverse

%% Image Parameters (ROW matrices)
W = size(Input,1); % Width
H = size(Input,2); % Height
C = [round(W/2), round(H/2)]; % Centre point

%% Backward Loop Method
for y = 1 : H
    for x = 1 : W
        P = [x, y];
        x_src = round(inverse * (P - C)' + C'); % Find source of P

        if x_src(1)< 1 | x_src(1) > W | x_src(2) < 1 | x_src(2) > H
            Rotated(x, y) = 0;
        else
            Rotated(x, y) = Input(x_src(1), x_src(2));
        end
    end
end