% test_adder.m  Test summation with multi-term non-monotonic adders.
%   This code uses the chop/CPFloat libraries for simulating custom
%   precision floating-point arithmetics.
%
%   Reference: M. Mikaitis. Monotonicity of multi-term floating-point
%              adders. 2023.

% Set up testing scenarios.
precisions =   [3,  3,  3, 4,  4,  4, 5,  5,  5];
maxexponents = [3,  3,  3, 3,  3,  3, 4,  4,  4];
terms =        [8, 16, 32, 8, 16, 32, 8, 32, 64];

% Set up the custom precision for chop/CPFloat.
options.format = 'c';
options.round = 1;

for experiment = 1:length(precisions)

    % Terms in the multi-term adder.
    T = terms(experiment);
    
    % Set up cpfloat.
    options.params = [precisions(experiment), maxexponents(experiment)];
    
    x = [];
    args = [];
    sums = [];
    sums0 = [];
    sums1 = [];
    i = 1;
    
    % Set up a vector with each element set to 0.25.
    for k = 1:T
        x(k) = 0.25;
    end
    
    % Increase x(1) and each time compute the sum of elements in x.
    while (x(1) ~= Inf)
        args(i) = x(1);
        sums0(i) = multi_term_add0(x, options);
        sums1(i) = multi_term_add1(x, options);
        sums(i) = sum(x);
    
        % Move x(1) to the adjacent floating-point value.
        [~, E] = log2(x(1));
        E = E - 1;
        increment = 2^(E-options.params(1)+1);
        x(1) = cpfloat(x(1) + increment, options);
        i = i + 1;
    end

    % Calculate errors relative to double precision sum.
    errors0 = (sums - sums0)./sums;
    errors1 = (sums - sums1)./sums;
    
    % Write sum values and errors to .dat files.
    filename = strcat('summation_values_p', ...
                       num2str(precisions(experiment)), 'emax', ...
                       num2str(maxexponents(experiment)), 'T', ...
                       num2str(terms(experiment)), '.dat');
    fileID = fopen(filename, 'w');
    fprintf(fileID, ['x1 sum sum-error sum-ieee754 sum-ieee754-error \n']);
    for i=1:length(args)
        fprintf(fileID,'%.10f %.10f %.10f %.10f %.10f \n', ...
            args(i), sums0(i), errors0(i), sums1(i), errors1(i));
    end
    
    figure
    plot(args,sums0,'-o',args,sums1,'x', 'LineWidth', 2);
    legend('custom', 'IEEE 754');

    figure
    plot(args,errors0,'-o',args,errors1,'x', 'LineWidth', 2);
    legend('custom', 'IEEE 754');
end