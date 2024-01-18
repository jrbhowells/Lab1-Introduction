function [Sheared] = Shear(Input, X, Y)
% Shear the image by X and Y in x and y directions.

%% Transformation Matrix
mat = [
    1 X;
    Y 1
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
        x_src = round((P - C) * inverse + C); % Find source of P

        if x_src(1)< 1 | x_src(1) > W | x_src(2) < 1 | x_src(2) > H
            Sheared(x, y) = 0;
        else
            Sheared(x, y) = Input(x_src(1), x_src(2));
        end
    end
end