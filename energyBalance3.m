function F = energyBalance3(T, numNodesX, numNodesY, Dx, Dy, k, hi, Ti_K, thickness)
    % T is a vector of unknown temperatures at nodal points 
    % F is a vector of energy balance equations 
    F = zeros(numNodesX * numNodesY, 1); % Initialize F
    % Loop over all nodes 
    for i = 1:numNodesX
        for j = 1:numNodesY
            % Calculate the index of the node in the vector T 
            index = (i - 1) * numNodesY + j;
            
            % Calculate coordinates for the current node
            x = (i - 1) * Dx;
            y = (j - 1) * Dy;
            
            % Check the location of the node 
            if i == 1 % Left symmetry line 
                F(index) = T(index) - T(index + 1); % T1 = T2
            elseif i == numNodesX % Right symmetry line 
                F(index) = T(index) - T(index - 1); % T9 = T8
            elseif j == 1 % Bottom symmetry line 
                F(index) = T(index) - T(index + numNodesY); % T1 = T4
            elseif j == numNodesY % Top symmetry line 
                F(index) = T(index) - T(index - numNodesY); % T3 = T6
            else % Interior node 
                % Energy balance equation 
                F(index) = k * (T(index - 1) - 2 * T(index) + T(index + 1)) / Dx^2 + ...,
                    k * (T(index - numNodesY) - 2 * T(index) + T(index + numNodesY)) / Dy^2 + ...
                    hi * (T(index) - Ti_K);
                
                % Additional term for thickness
                F(index) = F(index) + k * (T(index - numNodesY) - 2 * T(index) + T(index + numNodesY)) / thickness^2;

            end 
        end 
    end 
end
